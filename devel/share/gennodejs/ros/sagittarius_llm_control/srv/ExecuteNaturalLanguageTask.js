// Auto-generated. Do not edit!

// (in-package sagittarius_llm_control.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class ExecuteNaturalLanguageTaskRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.text = null;
      this.plan_only = null;
    }
    else {
      if (initObj.hasOwnProperty('text')) {
        this.text = initObj.text
      }
      else {
        this.text = '';
      }
      if (initObj.hasOwnProperty('plan_only')) {
        this.plan_only = initObj.plan_only
      }
      else {
        this.plan_only = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ExecuteNaturalLanguageTaskRequest
    // Serialize message field [text]
    bufferOffset = _serializer.string(obj.text, buffer, bufferOffset);
    // Serialize message field [plan_only]
    bufferOffset = _serializer.bool(obj.plan_only, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ExecuteNaturalLanguageTaskRequest
    let len;
    let data = new ExecuteNaturalLanguageTaskRequest(null);
    // Deserialize message field [text]
    data.text = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [plan_only]
    data.plan_only = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.text);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sagittarius_llm_control/ExecuteNaturalLanguageTaskRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e8adab1fa36d297994265126c222f182';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string text
    bool plan_only
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ExecuteNaturalLanguageTaskRequest(null);
    if (msg.text !== undefined) {
      resolved.text = msg.text;
    }
    else {
      resolved.text = ''
    }

    if (msg.plan_only !== undefined) {
      resolved.plan_only = msg.plan_only;
    }
    else {
      resolved.plan_only = false
    }

    return resolved;
    }
};

class ExecuteNaturalLanguageTaskResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.summary = null;
      this.plan_json = null;
      this.error = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('summary')) {
        this.summary = initObj.summary
      }
      else {
        this.summary = '';
      }
      if (initObj.hasOwnProperty('plan_json')) {
        this.plan_json = initObj.plan_json
      }
      else {
        this.plan_json = '';
      }
      if (initObj.hasOwnProperty('error')) {
        this.error = initObj.error
      }
      else {
        this.error = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ExecuteNaturalLanguageTaskResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [summary]
    bufferOffset = _serializer.string(obj.summary, buffer, bufferOffset);
    // Serialize message field [plan_json]
    bufferOffset = _serializer.string(obj.plan_json, buffer, bufferOffset);
    // Serialize message field [error]
    bufferOffset = _serializer.string(obj.error, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ExecuteNaturalLanguageTaskResponse
    let len;
    let data = new ExecuteNaturalLanguageTaskResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [summary]
    data.summary = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [plan_json]
    data.plan_json = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [error]
    data.error = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.summary);
    length += _getByteLength(object.plan_json);
    length += _getByteLength(object.error);
    return length + 13;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sagittarius_llm_control/ExecuteNaturalLanguageTaskResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '82ab653f3cc31c8822b11fe7224c5224';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
    string summary
    string plan_json
    string error
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ExecuteNaturalLanguageTaskResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.summary !== undefined) {
      resolved.summary = msg.summary;
    }
    else {
      resolved.summary = ''
    }

    if (msg.plan_json !== undefined) {
      resolved.plan_json = msg.plan_json;
    }
    else {
      resolved.plan_json = ''
    }

    if (msg.error !== undefined) {
      resolved.error = msg.error;
    }
    else {
      resolved.error = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: ExecuteNaturalLanguageTaskRequest,
  Response: ExecuteNaturalLanguageTaskResponse,
  md5sum() { return 'be00a685ab6aa4e4d8c4b100b3f5f4c6'; },
  datatype() { return 'sagittarius_llm_control/ExecuteNaturalLanguageTask'; }
};
