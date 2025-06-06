# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from demo02_sr75/candata.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class candata(genpy.Message):
  _md5sum = "319167d56da088e6bf38f02430def806"
  _type = "demo02_sr75/candata"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """int32 frameid
int32 datalen
int64[64] data
"""
  __slots__ = ['frameid','datalen','data']
  _slot_types = ['int32','int32','int64[64]']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       frameid,datalen,data

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(candata, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.frameid is None:
        self.frameid = 0
      if self.datalen is None:
        self.datalen = 0
      if self.data is None:
        self.data = [0] * 64
    else:
      self.frameid = 0
      self.datalen = 0
      self.data = [0] * 64

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
      buff.write(_get_struct_2i().pack(_x.frameid, _x.datalen))
      buff.write(_get_struct_64q().pack(*self.data))
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
      end += 8
      (_x.frameid, _x.datalen,) = _get_struct_2i().unpack(str[start:end])
      start = end
      end += 512
      self.data = _get_struct_64q().unpack(str[start:end])
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
      buff.write(_get_struct_2i().pack(_x.frameid, _x.datalen))
      buff.write(self.data.tostring())
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
      end += 8
      (_x.frameid, _x.datalen,) = _get_struct_2i().unpack(str[start:end])
      start = end
      end += 512
      self.data = numpy.frombuffer(str[start:end], dtype=numpy.int64, count=64)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_2i = None
def _get_struct_2i():
    global _struct_2i
    if _struct_2i is None:
        _struct_2i = struct.Struct("<2i")
    return _struct_2i
_struct_64q = None
def _get_struct_64q():
    global _struct_64q
    if _struct_64q is None:
        _struct_64q = struct.Struct("<64q")
    return _struct_64q
