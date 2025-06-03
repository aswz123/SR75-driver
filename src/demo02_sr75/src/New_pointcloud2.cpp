#include "ros/ros.h"
#include <sensor_msgs/PointCloud2.h>
#include <demo02_sr75/RadarCluster.h>
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>
#include <pcl_conversions/pcl_conversions.h>
#include <pcl/PCLPointCloud2.h>
#include <vector>

ros::Publisher pcl_pub;

void radarClusterCallback(const demo02_sr75::RadarCluster::ConstPtr& msg)
{
    // 单目标示例，若为数组请用vector批量处理
    pcl::PointCloud<pcl::PointXYZ> cloud;
    std::vector<float> velocities;

    // 这里只处理一个目标，如为数组请遍历
    pcl::PointXYZ pt;
    pt.x = msg->dist_lat_y;
    pt.y = msg->dist_long_x;
    pt.z = msg->height_z;
    cloud.points.push_back(pt);
    velocities.push_back(msg->velocity);

    cloud.width = cloud.points.size();
    cloud.height = 1;

    // 转为PCLPointCloud2
    pcl::PCLPointCloud2 pcl_pc2;
    pcl::toPCLPointCloud2(cloud, pcl_pc2);

    // 添加velocity字段
    pcl::PCLPointCloud2Modifier modifier(pcl_pc2);
    modifier.setPointCloud2Fields(4, "x", 1, sensor_msgs::PointField::FLOAT32,
                                     "y", 1, sensor_msgs::PointField::FLOAT32,
                                     "z", 1, sensor_msgs::PointField::FLOAT32,
                                     "velocity", 1, sensor_msgs::PointField::FLOAT32);

    // 填充velocity数据
    float* data_ptr = reinterpret_cast<float*>(&pcl_pc2.data[0]);
    for (size_t i = 0; i < cloud.points.size(); ++i)
    {
        data_ptr[i * 4 + 3] = velocities[i];
    }

    sensor_msgs::PointCloud2 output;
    pcl_conversions::fromPCL(pcl_pc2, output);
    output.header.frame_id = "odom";
    output.header.stamp = ros::Time::now();
    pcl_pub.publish(output);
}

int main(int argc, char *argv[])
{
    ros::init(argc, argv, "radar_cluster_to_cloud");
    ros::NodeHandle nh;
    pcl_pub = nh.advertise<sensor_msgs::PointCloud2>("pcl_output", 1);
    ros::Subscriber sub = nh.subscribe("radar_cluster", 100, radarClusterCallback);
    ros::spin();
    return 0;
}