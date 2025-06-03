#include "ros/ros.h"
#include <demo02_sr75/candata.h>
#include <sensor_msgs/PointCloud2.h>
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>
#include <pcl_conversions/pcl_conversions.h>

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
pcl::PointCloud<pcl::PointXYZI> cloud; // 使用XYZI
ros::Publisher pcl_pub;
std::vector<float> velocities;

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

            cloud.points[cluster_count].x = radar_data_cluster.Cluster_DistLat;
            cloud.points[cluster_count].y = radar_data_cluster.Cluster_DistLong;
            cloud.points[cluster_count].z = radar_data_cluster.Cluster_Height;
            cloud.points[cluster_count].intensity = static_cast<float>(radar_data_cluster.Cluster_RCS); // 使用RCS作为强度
            cluster_count++;
        }

        // ***所有点填充完毕后再发布点云***
        if(cluster_count >= cluster_num)
        {
            // 直接使用PCL提供的转换函数
            sensor_msgs::PointCloud2 msg;
            pcl::toROSMsg(cloud, msg);
            msg.header.frame_id = "odom";
            msg.header.stamp = ros::Time::now();
            
            // 添加velocity字段（可选，如果需要）
            // 这部分需要手动添加，类似于之前的代码...

            pcl_pub.publish(msg);
            velocities.clear();
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
