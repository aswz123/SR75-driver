#include "ros/ros.h"
#include <demo02_sr75/candata.h>
#include <sensor_msgs/PointCloud2.h>
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>
#include <pcl_conversions/pcl_conversions.h>
#include <pcl/PCLPointCloud2.h>

typedef struct {
    uint8_t   Cluster_ID;
    float     Cluster_DistLong;
    float     Cluster_DistLat;
    float     Cluster_VrelLong;
    float     Cluster_Height;
    uint8_t   Cluster_DynProp;
    uint8_t   Cluster_RCS;
}RadarPktBytes;
RadarPktBytes radar_data_cluster;

int cluster_num = 0;
int cluster_count = 0;
pcl::PointCloud<pcl::PointXYZ> cloud; // 不用XYZI
ros::Publisher pcl_pub;
sensor_msgs::PointCloud2 output;
std::vector<float> velocities;
std::vector<uint8_t> rcs_values;

void domsg(const demo02_sr75::candata::ConstPtr& candata)
{
    if(candata->frameid == 0x701)
    {
        int cluster_quantity = candata->datalen / 8;
        int clusters_to_process = std::min(cluster_quantity, cluster_num - cluster_count);

        for(int count = 0; count < clusters_to_process; count++)
        {
            if(cluster_count >= cloud.points.size())
            {
                ROS_WARN("Cluster count exceeds cloud size!");
                break;
            }
            // 原逻辑判断是否是最后一组CC数据
            if ((cluster_quantity == 6 || cluster_quantity == 8) && (cluster_quantity == count + 1))
            {
                if (std::all_of(&candata->data[8 * count], 
                                &candata->data[8 * count + 7], 
                                [](std::uint8_t value) { return value == 0xCC; })) 
                {
                    ROS_INFO("CCC");
                    break;     
                }
            }
            // 解析数据
            radar_data_cluster.Cluster_ID = candata->data[8 * count];
            double distlong = ((candata->data[8 * count + 1] << 5) + (candata->data[8 * count + 2] >> 3)) * 0.05 - 100;
            radar_data_cluster.Cluster_DistLong = distlong;
            double distlat = (((candata->data[8 * count + 2] & 0b111) << 8) + candata->data[8 * count + 3]) * 0.05 - 50;
            radar_data_cluster.Cluster_DistLat = distlat;
            double vrellong = ((candata->data[8 * count + 4] << 2) + (candata->data[8 * count + 4] >> 6)) * 0.05 - 16;
            radar_data_cluster.Cluster_VrelLong = vrellong;
            double height = (((candata->data[8 * count + 5] & 0b111111) << 3) + (candata->data[8 * count + 6] >> 5)) * 0.25 - 64;
            radar_data_cluster.Cluster_Height = height;
            radar_data_cluster.Cluster_RCS = candata->data[8 * count + 7];
            
            velocities.push_back(radar_data_cluster.Cluster_VrelLong);
            rcs_values.push_back(radar_data_cluster.Cluster_RCS);

            cloud.points[cluster_count].x = radar_data_cluster.Cluster_DistLat;
            cloud.points[cluster_count].y = radar_data_cluster.Cluster_DistLong;
            cloud.points[cluster_count].z = radar_data_cluster.Cluster_Height;
            cluster_count++;
        }

        // ***所有点填充完毕后再发布点云***
        if(cluster_count >= cluster_num)
        {
            sensor_msgs::PointCloud2 msg;
            msg.header.frame_id = "odom";
            msg.header.stamp = ros::Time::now();
            msg.height = 1;
            msg.width = cloud.points.size();
            msg.is_bigendian = false;
            msg.is_dense = true;

            // 定义字段 - 增加到5个字段
            msg.fields.resize(5);
            msg.fields[0].name = "x";
            msg.fields[0].offset = 0;
            msg.fields[0].datatype = sensor_msgs::PointField::FLOAT32;
            msg.fields[0].count = 1;

            msg.fields[1].name = "y";
            msg.fields[1].offset = 4;
            msg.fields[1].datatype = sensor_msgs::PointField::FLOAT32;
            msg.fields[1].count = 1;

            msg.fields[2].name = "z";
            msg.fields[2].offset = 8;
            msg.fields[2].datatype = sensor_msgs::PointField::FLOAT32;
            msg.fields[2].count = 1;

            msg.fields[3].name = "velocity";
            msg.fields[3].offset = 12;
            msg.fields[3].datatype = sensor_msgs::PointField::FLOAT32;
            msg.fields[3].count = 1;
            
            // 新增 intensity 字段
            msg.fields[4].name = "intensity";
            msg.fields[4].offset = 16;
            msg.fields[4].datatype = sensor_msgs::PointField::FLOAT32;
            msg.fields[4].count = 1;
            
            msg.point_step = 20; // 5 fields * 4 bytes
            msg.row_step = msg.point_step * msg.width;
            msg.data.resize(msg.row_step);

            // 填充数据
            for (size_t i = 0; i < cloud.points.size(); ++i)
            {
                float* ptr = (float*)(&msg.data[0] + i * msg.point_step);
                ptr[0] = cloud.points[i].x;
                ptr[1] = cloud.points[i].y;
                ptr[2] = cloud.points[i].z;
                ptr[3] = velocities[i];
                ptr[4] = static_cast<float>(radar_data_cluster.Cluster_RCS); // 将 RCS 转为 float 并存入
            }

            pcl_pub.publish(msg);
            velocities.clear();
            rcs_values.clear(); // 别忘了清空RCS值向量
        }
    }
    else if(candata->frameid == 0x600)
    {
        cluster_num = (candata->data[0] << 8) + candata->data[1];
        cloud.width = cluster_num;
        cloud.height = 1;
        cloud.points.resize(cloud.width * cloud.height);
        cluster_count = 0;
    }
}

int main(int argc, char *argv[])
{
    setlocale(LC_ALL,"");
    ros::init(argc,argv,"radar_analysis");
    ros::NodeHandle nh;
    ros::Subscriber sub = nh.subscribe<demo02_sr75::candata>("candata",1000,domsg);
    pcl_pub = nh.advertise<sensor_msgs::PointCloud2> ("pcl_output", 1);
    ros::spin();
    return 0;
}
