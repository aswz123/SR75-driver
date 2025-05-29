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

class candata {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.frameid = null;
      this.datalen = null;
      this.data = null;
    }
    else {
      if (initObj.hasOwnProperty('frameid')) {
        this.frameid = initObj.frameid
      }
      else {
        this.frameid = 0;
      }
      if (initObj.hasOwnProperty('datalen')) {
        this.datalen = initObj.datalen
      }
      else {
        this.datalen = 0;
      }
      if (initObj.hasOwnProperty('data')) {
        this.data = initObj.data
      }
      else {
        this.data = new Array(64).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type candata
    // Serialize message field [frameid]
    bufferOffset = _serializer.int32(obj.frameid, buffer, bufferOffset);
    // Serialize message field [datalen]
    bufferOffset = _serializer.int32(obj.datalen, buffer, bufferOffset);
    // Check that the constant length array field [data] has the right length
    if (obj.data.length !== 64) {
      throw new Error('Unable to serialize array field data - length must be 64')
    }
    // Serialize message field [data]
    bufferOffset = _arraySerializer.int64(obj.data, buffer, bufferOffset, 64);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type candata
    let len;
    let data = new candata(null);
    // Deserialize message field [frameid]
    data.frameid = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [datalen]
    data.datalen = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [data]
    data.data = _arrayDeserializer.int64(buffer, bufferOffset, 64)
    return data;
  }

  static getMessageSize(object) {
    return 520;
  }

  static datatype() {
    // Returns string type for a message object
    return 'demo02_sr75/candata';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '319167d56da088e6bf38f02430def806';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 frameid
    int32 datalen
    int64[64] data
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new candata(null);
    if (msg.frameid !== undefined) {
      resolved.frameid = msg.frameid;
    }
    else {
      resolved.frameid = 0
    }

    if (msg.datalen !== undefined) {
      resolved.datalen = msg.datalen;
    }
    else {
      resolved.datalen = 0
    }

    if (msg.data !== undefined) {
      resolved.data = msg.data;
    }
    else {
      resolved.data = new Array(64).fill(0)
    }

    return resolved;
    }
};

module.exports = candata;
