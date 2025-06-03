// Auto-generated. Do not edit!

// (in-package demo02_sr75.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class RadarCluster {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.dist_long_x = null;
      this.dist_lat_y = null;
      this.velocity = null;
      this.height_z = null;
      this.dyn_prop = null;
      this.rcs = null;
      this.range = null;
      this.angle = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('dist_long_x')) {
        this.dist_long_x = initObj.dist_long_x
      }
      else {
        this.dist_long_x = 0.0;
      }
      if (initObj.hasOwnProperty('dist_lat_y')) {
        this.dist_lat_y = initObj.dist_lat_y
      }
      else {
        this.dist_lat_y = 0.0;
      }
      if (initObj.hasOwnProperty('velocity')) {
        this.velocity = initObj.velocity
      }
      else {
        this.velocity = 0.0;
      }
      if (initObj.hasOwnProperty('height_z')) {
        this.height_z = initObj.height_z
      }
      else {
        this.height_z = 0.0;
      }
      if (initObj.hasOwnProperty('dyn_prop')) {
        this.dyn_prop = initObj.dyn_prop
      }
      else {
        this.dyn_prop = 0;
      }
      if (initObj.hasOwnProperty('rcs')) {
        this.rcs = initObj.rcs
      }
      else {
        this.rcs = 0;
      }
      if (initObj.hasOwnProperty('range')) {
        this.range = initObj.range
      }
      else {
        this.range = 0.0;
      }
      if (initObj.hasOwnProperty('angle')) {
        this.angle = initObj.angle
      }
      else {
        this.angle = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RadarCluster
    // Serialize message field [id]
    bufferOffset = _serializer.uint8(obj.id, buffer, bufferOffset);
    // Serialize message field [dist_long_x]
    bufferOffset = _serializer.float32(obj.dist_long_x, buffer, bufferOffset);
    // Serialize message field [dist_lat_y]
    bufferOffset = _serializer.float32(obj.dist_lat_y, buffer, bufferOffset);
    // Serialize message field [velocity]
    bufferOffset = _serializer.float32(obj.velocity, buffer, bufferOffset);
    // Serialize message field [height_z]
    bufferOffset = _serializer.float32(obj.height_z, buffer, bufferOffset);
    // Serialize message field [dyn_prop]
    bufferOffset = _serializer.uint8(obj.dyn_prop, buffer, bufferOffset);
    // Serialize message field [rcs]
    bufferOffset = _serializer.uint8(obj.rcs, buffer, bufferOffset);
    // Serialize message field [range]
    bufferOffset = _serializer.float32(obj.range, buffer, bufferOffset);
    // Serialize message field [angle]
    bufferOffset = _serializer.float32(obj.angle, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RadarCluster
    let len;
    let data = new RadarCluster(null);
    // Deserialize message field [id]
    data.id = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [dist_long_x]
    data.dist_long_x = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dist_lat_y]
    data.dist_lat_y = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [velocity]
    data.velocity = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [height_z]
    data.height_z = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dyn_prop]
    data.dyn_prop = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [rcs]
    data.rcs = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [range]
    data.range = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [angle]
    data.angle = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 27;
  }

  static datatype() {
    // Returns string type for a message object
    return 'demo02_sr75/RadarCluster';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fe99fd61eb81690cb0da1c8e2444952c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8   id              # 目标ID，0~255循环,随机
    float32 dist_long_x       # 目标纵向距离，单位：米
    float32 dist_lat_y        # 目标横向距离，单位：米
    float32 velocity        # 目标径向速度，单位：m/s
    float32 height_z          # 目标高度，单位：米
    uint8   dyn_prop        # 目标动态属性
    uint8   rcs             # 目标信噪比
    float32 range           # 目标径向距离R，单位：米
    float32 angle           # 目标角度θ，单位：弧度
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RadarCluster(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.dist_long_x !== undefined) {
      resolved.dist_long_x = msg.dist_long_x;
    }
    else {
      resolved.dist_long_x = 0.0
    }

    if (msg.dist_lat_y !== undefined) {
      resolved.dist_lat_y = msg.dist_lat_y;
    }
    else {
      resolved.dist_lat_y = 0.0
    }

    if (msg.velocity !== undefined) {
      resolved.velocity = msg.velocity;
    }
    else {
      resolved.velocity = 0.0
    }

    if (msg.height_z !== undefined) {
      resolved.height_z = msg.height_z;
    }
    else {
      resolved.height_z = 0.0
    }

    if (msg.dyn_prop !== undefined) {
      resolved.dyn_prop = msg.dyn_prop;
    }
    else {
      resolved.dyn_prop = 0
    }

    if (msg.rcs !== undefined) {
      resolved.rcs = msg.rcs;
    }
    else {
      resolved.rcs = 0
    }

    if (msg.range !== undefined) {
      resolved.range = msg.range;
    }
    else {
      resolved.range = 0.0
    }

    if (msg.angle !== undefined) {
      resolved.angle = msg.angle;
    }
    else {
      resolved.angle = 0.0
    }

    return resolved;
    }
};

module.exports = RadarCluster;
