#include "ros/ros.h"
#include <demo02_sr75/candata.h>
#include <demo02_sr75/RadarCluster.h>
#include <cmath>

void candataCallback(const demo02_sr75::candata::ConstPtr& candata, ros::Publisher* pub)
{
    if (candata->frameid == 0x701)
    {
        int cluster_quantity = candata->datalen / 8;
        for (int count = 0; count < cluster_quantity; count++)
        {
            uint8_t id = candata->data[8 * count];
            float dist_long_x = ((candata->data[8 * count + 1] << 5) + (candata->data[8 * count + 2] >> 3)) * 0.05f - 100.0f;
            float dist_lat_y = (((candata->data[8 * count + 2] & 0b111) << 8) + candata->data[8 * count + 3]) * 0.05f - 50.0f;
            float velocity = ((candata->data[8 * count + 4] << 2) + (candata->data[8 * count + 4] >> 6)) * 0.05f - 16.0f;
            float height_z = (((candata->data[8 * count + 5] & 0b111111) << 3) + (candata->data[8 * count + 6] >> 5)) * 0.25f - 64.0f;
            uint8_t dyn_prop = candata->data[8 * count + 6] & 0b111;
            uint8_t rcs = candata->data[8 * count + 7];
            float range = std::sqrt(dist_long_x * dist_long_x + dist_lat_y * dist_lat_y);
            float angle = std::atan2(dist_lat_y, dist_long_x);

            demo02_sr75::RadarCluster msg;
            msg.id = id;
            msg.dist_long_x = dist_long_x;
            msg.dist_lat_y = dist_lat_y;
            msg.velocity = velocity;
            msg.height_z = height_z;
            msg.dyn_prop = dyn_prop;
            msg.rcs = rcs;
            msg.range = range;
            msg.angle = angle;

            pub->publish(msg);
        }
    }
}

int main(int argc, char** argv)
{
    ros::init(argc, argv, "radar_cluster_publisher");
    ros::NodeHandle nh;
    ros::Publisher cluster_pub = nh.advertise<demo02_sr75::RadarCluster>("radar_cluster", 100);
    ros::Subscriber sub = nh.subscribe<demo02_sr75::candata>(
        "candata", 1000, boost::bind(candataCallback, _1, &cluster_pub));
    ros::spin();
    return 0;
}