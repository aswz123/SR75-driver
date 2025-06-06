# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from demo02_sr75/RadarCluster.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class RadarCluster(genpy.Message):
  _md5sum = "fe99fd61eb81690cb0da1c8e2444952c"
  _type = "demo02_sr75/RadarCluster"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """uint8   id              # 目标ID，0~255循环,随机
float32 dist_long_x       # 目标纵向距离，单位：米
float32 dist_lat_y        # 目标横向距离，单位：米
float32 velocity        # 目标径向速度，单位：m/s
float32 height_z          # 目标高度，单位：米
uint8   dyn_prop        # 目标动态属性
uint8   rcs             # 目标信噪比
float32 range           # 目标径向距离R，单位：米
float32 angle           # 目标角度θ，单位：弧度"""
  __slots__ = ['id','dist_long_x','dist_lat_y','velocity','height_z','dyn_prop','rcs','range','angle']
  _slot_types = ['uint8','float32','float32','float32','float32','uint8','uint8','float32','float32']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       id,dist_long_x,dist_lat_y,velocity,height_z,dyn_prop,rcs,range,angle

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(RadarCluster, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.id is None:
        self.id = 0
      if self.dist_long_x is None:
        self.dist_long_x = 0.
      if self.dist_lat_y is None:
        self.dist_lat_y = 0.
      if self.velocity is None:
        self.velocity = 0.
      if self.height_z is None:
        self.height_z = 0.
      if self.dyn_prop is None:
        self.dyn_prop = 0
      if self.rcs is None:
        self.rcs = 0
      if self.range is None:
        self.range = 0.
      if self.angle is None:
        self.angle = 0.
    else:
      self.id = 0
      self.dist_long_x = 0.
      self.dist_lat_y = 0.
      self.velocity = 0.
      self.height_z = 0.
      self.dyn_prop = 0
      self.rcs = 0
      self.range = 0.
      self.angle = 0.

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_B4f2B2f().pack(_x.id, _x.dist_long_x, _x.dist_lat_y, _x.velocity, _x.height_z, _x.dyn_prop, _x.rcs, _x.range, _x.angle))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      _x = self
      start = end
      end += 27
      (_x.id, _x.dist_long_x, _x.dist_lat_y, _x.velocity, _x.height_z, _x.dyn_prop, _x.rcs, _x.range, _x.angle,) = _get_struct_B4f2B2f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_B4f2B2f().pack(_x.id, _x.dist_long_x, _x.dist_lat_y, _x.velocity, _x.height_z, _x.dyn_prop, _x.rcs, _x.range, _x.angle))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      _x = self
      start = end
      end += 27
      (_x.id, _x.dist_long_x, _x.dist_lat_y, _x.velocity, _x.height_z, _x.dyn_prop, _x.rcs, _x.range, _x.angle,) = _get_struct_B4f2B2f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_B4f2B2f = None
def _get_struct_B4f2B2f():
    global _struct_B4f2B2f
    if _struct_B4f2B2f is None:
        _struct_B4f2B2f = struct.Struct("<B4f2B2f")
    return _struct_B4f2B2f
