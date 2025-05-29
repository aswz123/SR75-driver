#include "ros/ros.h"
#include "demo02_sr75/candata.h"
// #include "demo02_sr75/controlcan.h"
#include <iostream>
#include <sys/time.h>
#include <stdio.h>
#include <sstream>
#include <dlfcn.h>
#include <unistd.h>
#include "demo02_sr75/controlcanfd.h"
#include <stdlib.h>
#include <string.h>


#define MAX_CHANNELS  4
#define CHECK_POINT  200
#define RX_WAIT_TIME  1000
#define RX_BUFF_SIZE  1000

using namespace std;

typedef DEVICE_HANDLE(*pZCAN_OpenDevice)(UINT deviceType, UINT deviceIndex, UINT reserved);
typedef UINT(*pZCAN_CloseDevice)(DEVICE_HANDLE device_handle);
typedef UINT(*pZCAN_GetDeviceInf)(DEVICE_HANDLE device_handle, ZCAN_DEVICE_INFO* pInfo);
typedef UINT(*pZCAN_IsDeviceOnLine)(DEVICE_HANDLE device_handle);
typedef CHANNEL_HANDLE(*pZCAN_InitCAN)(DEVICE_HANDLE device_handle, UINT can_index, ZCAN_CHANNEL_INIT_CONFIG* pInitConfig);
typedef UINT(*pZCAN_StartCAN)(CHANNEL_HANDLE channel_handle);
typedef UINT(*pZCAN_ResetCAN)(CHANNEL_HANDLE channel_handle);
typedef UINT(*pZCAN_ClearBuffer)(CHANNEL_HANDLE channel_handle);
typedef UINT(*pZCAN_GetReceiveNum)(CHANNEL_HANDLE channel_handle, BYTE type); // type:TYPE_CAN TYPE_CANFD
typedef UINT(*pZCAN_Transmit)(CHANNEL_HANDLE channel_handle, ZCAN_Transmit_Data* pTransmit, UINT len);
typedef UINT(*pZCAN_Receive)(CHANNEL_HANDLE channel_handle, ZCAN_Receive_Data* pReceive, UINT len, int wait_time);
typedef UINT(*pZCAN_TransmitFD)(CHANNEL_HANDLE channel_handle, ZCAN_TransmitFD_Data* pTransmit, UINT len);
typedef UINT(*pZCAN_ReceiveFD)(CHANNEL_HANDLE channel_handle, ZCAN_ReceiveFD_Data* pReceive, UINT len, int wait_time);
typedef IProperty* (*pGetIProperty)(DEVICE_HANDLE device_handle);
typedef UINT(*pReleaseIProperty)(IProperty* pIProperty);
typedef UINT(*pZCAN_SetAbitBaud)(DEVICE_HANDLE device_handle, UINT can_index, UINT abitbaud);
typedef UINT(*pZCAN_SetDbitBaud)(DEVICE_HANDLE device_handle, UINT can_index, UINT dbitbaud);
typedef UINT(*pZCAN_SetCANFDStandard)(DEVICE_HANDLE device_handle, UINT can_index, UINT canfd_standard);
typedef UINT(*pZCAN_SetResistanceEnable)(DEVICE_HANDLE device_handle, UINT can_index, UINT enable);
typedef UINT(*pZCAN_SetBaudRateCustom)(DEVICE_HANDLE device_handle, UINT can_index, char* RateCustom);
typedef UINT(*pZCAN_ClearFilter)(CHANNEL_HANDLE channel_handle);
typedef UINT(*pZCAN_AckFilter)(CHANNEL_HANDLE channel_handle);
typedef UINT(*pZCAN_SetFilterMode)(CHANNEL_HANDLE channel_handle, UINT mode);
typedef UINT(*pZCAN_SetFilterStartID)(CHANNEL_HANDLE channel_handle, UINT start_id);
typedef UINT(*pZCAN_SetFilterEndID)(CHANNEL_HANDLE channel_handle, UINT EndID);

pZCAN_OpenDevice zcan_open_device;
pZCAN_CloseDevice zcan_close_device;
pZCAN_GetDeviceInf zcan_get_device_inf;
pZCAN_IsDeviceOnLine zcan_is_device_online;
pZCAN_InitCAN zcan_init_can;
pZCAN_StartCAN zcan_start_can;
pZCAN_ResetCAN zcan_reset_can;
pZCAN_ClearBuffer zcan_clear_buffer;
pZCAN_GetReceiveNum zcan_get_receive_num;
pZCAN_Transmit zcan_transmit;
pZCAN_Receive zcan_receive;
pZCAN_TransmitFD zcan_transmit_fd;
pZCAN_ReceiveFD zcan_receive_fd;
pGetIProperty get_iproperty;
pReleaseIProperty release_iproperty;
pZCAN_SetAbitBaud zcan_set_abit_baud;
pZCAN_SetDbitBaud zcan_set_dbit_baud;
pZCAN_SetCANFDStandard zcan_set_canfd_standard;
pZCAN_SetResistanceEnable zcan_set_resistance_enable;
pZCAN_SetBaudRateCustom zcan_set_baud_rate_custom;
pZCAN_ClearFilter zcan_clear_filter;
pZCAN_AckFilter zcan_ack_filter;
pZCAN_SetFilterMode zcan_set_filter_mode;
pZCAN_SetFilterStartID zcan_set_filter_start_id;
pZCAN_SetFilterEndID zcan_set_filter_end_id;

// so 句柄
void* m_h_ins_drv = nullptr;

// 设备句柄
DEVICE_HANDLE m_h_device[16];
// 通道句柄
CHANNEL_HANDLE m_h_channel[16][16];

int device_index = 0;
int device_type = 0;

static void uti_unpack(unsigned char* pSrc, unsigned char* pDest, int len)
{
    unsigned char ch1, ch2;
    int i;
    for (i = 0; i < len; i++)
    {
        ch1 = (pSrc[i] & 0xF0) >> 4;
        ch2 = pSrc[i] & 0x0F;
        ch1 += ((ch1 > 9) ? 0x37 : 0x30);
        ch2 += ((ch2 > 9) ? 0x37 : 0x30);
        pDest[i * 2] = ch1;
        pDest[i * 2 + 1] = ch2;
    }
}

static void uti_pack(unsigned char* pSrc, unsigned char* pDest, int len)
{
    char ch1, ch2;
    int i;
    for (i = 0; i < (len / 2); i++)
    {
        ch1 = pSrc[i * 2];
        ch2 = pSrc[i * 2 + 1];
        (ch1 >= 'a' && ch1 <= 'z') ? (ch1 -= 32) : (ch1);
        (ch2 >= 'a' && ch2 <= 'z') ? (ch2 -= 32) : (ch2);
        ch1 -= ((ch1 > '9') ? 0x37 : 0x30);
        ch2 -= ((ch2 > '9') ? 0x37 : 0x30);
        pDest[i] = (ch1 << 4) | ch2;
    }
}

void hex_num_to_string(int hex_num, char* out)
{
    if (out == nullptr)
    {
        return;
    }
    sprintf(out, "%x", hex_num);
}
int load_so_dll()
{
    m_h_ins_drv = dlopen("/lib/libcontrolcanfd.so", RTLD_LAZY);
    if (!m_h_ins_drv)
    {
        printf("load_so_dll dlopen error:%s\n", dlerror());
        return -1;
    }
    else
    {
        zcan_open_device = (pZCAN_OpenDevice)dlsym(m_h_ins_drv, "ZCAN_OpenDevice");
        zcan_close_device = (pZCAN_CloseDevice)dlsym(m_h_ins_drv, "ZCAN_CloseDevice");
        zcan_get_device_inf = (pZCAN_GetDeviceInf)dlsym(m_h_ins_drv, "ZCAN_GetDeviceInf");
        zcan_is_device_online = (pZCAN_IsDeviceOnLine)dlsym(m_h_ins_drv, "ZCAN_IsDeviceOnLine");
        zcan_init_can = (pZCAN_InitCAN)dlsym(m_h_ins_drv, "ZCAN_InitCAN");
        zcan_start_can = (pZCAN_StartCAN)dlsym(m_h_ins_drv, "ZCAN_StartCAN");
        zcan_reset_can = (pZCAN_ResetCAN)dlsym(m_h_ins_drv, "ZCAN_ResetCAN");
        zcan_clear_buffer = (pZCAN_ClearBuffer)dlsym(m_h_ins_drv, "ZCAN_ClearBuffer");
        zcan_get_receive_num = (pZCAN_GetReceiveNum)dlsym(m_h_ins_drv, "ZCAN_GetReceiveNum");
        zcan_transmit = (pZCAN_Transmit)dlsym(m_h_ins_drv, "ZCAN_Transmit");
        zcan_receive = (pZCAN_Receive)dlsym(m_h_ins_drv, "ZCAN_Receive");
        zcan_transmit_fd = (pZCAN_TransmitFD)dlsym(m_h_ins_drv, "ZCAN_TransmitFD");
        zcan_receive_fd = (pZCAN_ReceiveFD)dlsym(m_h_ins_drv, "ZCAN_ReceiveFD");
        get_iproperty = (pGetIProperty)dlsym(m_h_ins_drv, "GetIProperty");
        release_iproperty = (pReleaseIProperty)dlsym(m_h_ins_drv, "ReleaseIProperty");
        zcan_set_abit_baud = (pZCAN_SetAbitBaud)dlsym(m_h_ins_drv, "ZCAN_SetAbitBaud");
        zcan_set_dbit_baud = (pZCAN_SetDbitBaud)dlsym(m_h_ins_drv, "ZCAN_SetDbitBaud");
        zcan_set_canfd_standard = (pZCAN_SetCANFDStandard)dlsym(m_h_ins_drv, "ZCAN_SetCANFDStandard");
        zcan_set_resistance_enable = (pZCAN_SetResistanceEnable)dlsym(m_h_ins_drv, "ZCAN_SetResistanceEnable");
        zcan_set_baud_rate_custom = (pZCAN_SetBaudRateCustom)dlsym(m_h_ins_drv, "ZCAN_SetBaudRateCustom");
        zcan_clear_filter = (pZCAN_ClearFilter)dlsym(m_h_ins_drv, "ZCAN_ClearFilter");
        zcan_ack_filter = (pZCAN_AckFilter)dlsym(m_h_ins_drv, "ZCAN_AckFilter");
        zcan_set_filter_mode = (pZCAN_SetFilterMode)dlsym(m_h_ins_drv, "ZCAN_SetFilterMode");
        zcan_set_filter_start_id = (pZCAN_SetFilterStartID)dlsym(m_h_ins_drv, "ZCAN_SetFilterStartID");
        zcan_set_filter_end_id = (pZCAN_SetFilterEndID)dlsym(m_h_ins_drv, "ZCAN_SetFilterEndID");
    }
    if (!zcan_open_device || !zcan_close_device || !zcan_get_device_inf || !zcan_is_device_online || !zcan_init_can || !zcan_start_can || !zcan_reset_can || !zcan_clear_buffer || !zcan_get_receive_num || !zcan_transmit || !zcan_receive || !zcan_transmit_fd || !zcan_receive_fd || !get_iproperty || !release_iproperty || !zcan_set_abit_baud || !zcan_set_dbit_baud || !zcan_set_canfd_standard || !zcan_set_resistance_enable || !zcan_set_baud_rate_custom || !zcan_clear_filter || !zcan_clear_filter || !zcan_ack_filter || !zcan_set_filter_mode || !zcan_set_filter_start_id || !zcan_set_filter_end_id)
    {
        printf("load_so_dll dlsym error:%s\n", dlerror());
        return -2;
    }
    return 0;
}

int initCAN(int can_index)
{
    int filter = 1;
    int mode = 0;
    int canType = 1;

    ZCAN_CHANNEL_INIT_CONFIG zcan_channel_init_config;
    zcan_channel_init_config.can_type = canType;

    zcan_channel_init_config.canfd.acc_code = 0;
    zcan_channel_init_config.canfd.acc_mask = 0xFFFFFFFF;
    zcan_channel_init_config.canfd.filter = filter;
    zcan_channel_init_config.canfd.mode = mode;
    zcan_channel_init_config.canfd.brp = 0;

    CHANNEL_HANDLE channel_handle = zcan_init_can(m_h_device[device_index], can_index, &zcan_channel_init_config);
    if (channel_handle == INVALID_CHANNEL_HANDLE)
    {
        cout << "初始化通道失败！" << endl;
        return -1;
    }
    m_h_channel[device_index][can_index] = channel_handle;
    return 0;
}

int start_can(int can_index)
{
    int ret = zcan_start_can(m_h_channel[device_index][can_index]);
    if (ret != STATUS_OK)
    {
        ROS_INFO("启动CAN失败！ ");
        return -1;
    }
    return 0;
}

int clear_filter(int can_index)
{
    int ret = zcan_clear_filter(m_h_channel[device_index][can_index]);
    if (ret != STATUS_OK)
    {
        ROS_INFO("清除滤波器失败！");
        return -1;
    }
    return 0;
}

int set_filter_mode(int can_index)
{
    int mode = 0;
    int ret = zcan_set_filter_mode(m_h_channel[device_index][can_index], mode);
    if (ret != STATUS_OK)
    {
        ROS_INFO("配置通道滤波模式");
        return -1;
    }
    return 0;
}

int set_filter_start_id(int can_index, int start_id)
{
    int mode = 0;
    int ret = zcan_set_filter_start_id(m_h_channel[device_index][can_index], mode);
    if (ret != STATUS_OK)
    {
        cout << "配置通道滤波起始id" << endl;
        return -1;
    }
    return 0;
}

int set_filter_end_id(int can_index, int end_id)
{
    int mode = 0;
    int ret = zcan_set_filter_end_id(m_h_channel[device_index][can_index], mode);
    if (ret != STATUS_OK)
    {
        cout << "配置通道滤波结束id" << endl;
        return -1;
    }
    return 0;
}

int ack_filter(int can_index)
{
    int mode = 0;
    int ret = zcan_ack_filter(m_h_channel[device_index][can_index]);
    if (ret != STATUS_OK)
    {
        cout << "生效通道滤波设置" << endl;
        return -1;
    }
    return 0;
}

int message_count = 0;

int main(int argc, char *argv[])
{
    uint32_t frame_id;
    uint8_t dlc;
    uint8_t data[64] = {0};

    setlocale(LC_ALL,"");
    ros::init(argc,argv,"radar");
    ros::NodeHandle nh;
    ros::Publisher pub = nh.advertise<demo02_sr75::candata>("candata",1000);

    // 动态加载so，函数指针
    if (load_so_dll() != 0)
    {
        return -1;
    }

    // 打开设备
    DEVICE_HANDLE dev_handle = zcan_open_device(USBCANFD_200U, device_index, 0);
    if (dev_handle == INVALID_DEVICE_HANDLE)
    {
        ROS_INFO("打开设备失败！");
        return -1;
    }
    ROS_INFO("打开设备成功！");
    m_h_device[device_index] = dev_handle;

    // 配置波特率
    if (STATUS_OK != zcan_set_abit_baud(m_h_device[device_index], 0, 1000000))
    {
        ROS_INFO("et_abit_baud 0 Error");
    }
    else
    {
        ROS_INFO("set_abit_baud 0 Succ");
    }
    if (STATUS_OK != zcan_set_dbit_baud(m_h_device[device_index], 0, 4000000))
    {
        ROS_INFO("set_dbit_baud Error");
    }
    else
    {
        ROS_INFO("set_dbit_baud 0 Succ");
    }

    ROS_INFO("初始化通道1");
    int ret = initCAN(0);
    if (ret != 0)
    {
        cout << "初始化通道1失败！" << endl;
        return -1;
    }
    usleep(100000);

    ROS_INFO("清除通道1滤波设置");
    ret = clear_filter(0);
    usleep(100000);

    ROS_INFO("生效通道1滤波设置");
    ret = ack_filter(0);
    usleep(100000);

    ROS_INFO("启动通道1");
    ret = start_can(0);
    usleep(100000);

    int times = 5000;
    int printf_len = 0;
    int wait_time = 100;
    ZCAN_ReceiveFD_Data zcan_receive_fd_data[3000];
    int can_index = 0;
    // int cnt=0; 

    demo02_sr75::candata candata ;
    candata.frameid = 0;
    candata.datalen = 0;
    for (int i=0;i<64;i++)
    {
        candata.data[i] = 0;
    }
    // int count = 0;
    while(ros::ok())
    {
        int real_len = zcan_receive_fd(m_h_channel[device_index][can_index], zcan_receive_fd_data, 3000, wait_time); 
        if(!real_len)
        {
            continue;
        }

        for(int i = 0; i < real_len; i++)
        {
            std::fill(std::begin(candata.data), std::end(candata.data), 0);
            candata.frameid = zcan_receive_fd_data[i].frame.can_id;
            candata.datalen = zcan_receive_fd_data[i].frame.len;
            for(int j=0;j<candata.datalen;j++)
            {
                candata.data[j] = zcan_receive_fd_data[i].frame.data[j];
            }
            pub.publish(candata);
            ros::spinOnce();
        }
    }

    zcan_reset_can(m_h_channel[device_index][0]); // 复位CAN1通道。
    usleep(100000);                               
    // 关闭设备
    zcan_close_device(m_h_device[device_index]);
    ROS_INFO("关闭设备");
    return 0;
}