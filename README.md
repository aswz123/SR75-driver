# SR75 Radar Driver

一个基于ROS的SR75毫米波雷达驱动程序，用于通过CAN总线与SR75雷达传感器进行通信。

## 项目概述

本项目提供了SR75毫米波雷达的完整ROS驱动程序，支持雷达数据的接收、解析和发布。主要功能包括：

- 通过CAN总线接收雷达原始数据
- 解析雷达信号并生成点云数据
- 发布雷达目标聚类信息
- 支持多种雷达数据格式输出

## 系统要求

- **操作系统**: Ubuntu 16.04 / 18.04 / 20.04
- **ROS版本**: ROS Kinetic / Melodic / Noetic
- **依赖库**: 
  - roscpp
  - std_msgs
  - sensor_msgs
  - geometry_msgs

## 功能特性

### 主要模块

1. **CAN数据获取模块** (`get_can_data.cpp`)
   - 通过CAN总线接收雷达原始数据
   - 支持CAN FD协议
   - 实时数据处理

2. **雷达信息聚类模块** (`get_radar_info_cluster.cpp`)
   - 解析雷达原始数据
   - 目标检测和聚类
   - 生成雷达目标信息

3. **点云生成模块** (`New_pointcloud2.cpp`)
   - 将雷达数据转换为ROS点云格式
   - 支持PointCloud2消息类型

4. **雷达聚类发布模块** (`publish_radar_cluster.cpp`)
   - 发布处理后的雷达目标聚类信息
   - 提供标准ROS接口

### 消息类型

- `candata.msg`: CAN总线原始数据消息
- `RadarCluster.msg`: 雷达目标聚类信息消息

## 安装指南

### 1. 创建工作空间

```bash
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
```

### 2. 克隆项目

```bash
git clone <repository-url> sr75_driver
cd ~/catkin_ws
```

### 3. 安装依赖

```bash
rosdep install --from-paths src --ignore-src -r -y
```

### 4. 编译项目

```bash
catkin_make
source devel/setup.bash
```

## 使用方法

### 1. 配置CAN设备

确保CAN设备已正确连接并配置

### 2. 启动驱动程序

```bash
# 启动SR75雷达驱动
roslaunch demo02_sr75 demo02_sr75.launch
```

### 3. 查看数据

```bash
# 查看可用话题
rostopic list

# 查看雷达数据
rostopic echo /radar_cluster

# 查看点云数据
rostopic echo /radar_pointcloud
```

## 配置说明

### Launch文件参数

在 `launch/demo02_sr75.launch` 中可以配置以下参数：

- CAN设备ID
- 雷达工作频率
- 数据发布频率
- 滤波参数

### 消息格式

#### RadarCluster消息

```
Header header
uint32 cluster_id
float32 range
float32 angle
float32 velocity
float32 rcs
```

## 故障排除

### 常见问题

1. **CAN设备无法识别**
   - 检查CAN设备连接
   - 确认设备驱动已安装
   - 验证设备权限设置

2. **没有数据输出**
   - 检查雷达电源连接
   - 确认CAN总线配置正确
   - 检查launch文件参数设置

3. **编译错误**
   - 确认ROS环境已正确设置
   - 检查依赖包是否完整安装
   - 验证CMakeLists.txt配置

### 调试方法

```bash
# 检查CAN总线状态
candump can0

# 查看节点状态
rosnode list
rosnode info /sr75_driver

# 检查消息频率
rostopic hz /radar_cluster
```

## 开发说明

### 项目结构

```
src/demo02_sr75/
├── CMakeLists.txt
├── package.xml
├── config/              # 配置文件
├── include/             # 头文件
├── launch/              # Launch文件
├── msg/                 # 消息定义
├── src/                 # 源代码
└── lib/                 # 库文件
```

### 二次开发

如需自定义功能，建议：

1. 修改消息定义以适应特定需求
2. 调整数据处理算法
3. 添加新的发布话题
4. 集成其他传感器数据

## 许可证

本项目采用 [许可证名称] 许可证。详见 LICENSE 文件。


## 更新日志

### v0.0.1
- 初始版本发布
- 基本CAN数据接收功能
- 雷达数据解析和发布

---

**注意**: 使用前请确保已正确安装ROS环境和相关依赖包。
