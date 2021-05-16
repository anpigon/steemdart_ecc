import 'dart:convert';
import 'dart:typed_data';

int calculateVarint32(int value) {
  // ref: src/google/protobuf/io/coded_stream.cc
  value = (value & 0xffffffff) >> 0;
  if (value < 1 << 7)
    return 1;
  else if (value < 1 << 14)
    return 2;
  else if (value < 1 << 21)
    return 3;
  else if (value < 1 << 28)
    return 4;
  else
    return 5;
}

abstract class Serializer<T extends dynamic> {
  void appendByteBuffer(BytesBuilder buffer, T value) {}
}

class UInt16Serializer implements Serializer<int> {
  @override
  void appendByteBuffer(buffer, value) {
    ByteData byte = ByteData(2);
    byte.setUint16(0, value, Endian.little);
    buffer.add(byte.buffer.asUint8List());
  }
}

class UInt32Serializer implements Serializer<int> {
  @override
  void appendByteBuffer(buffer, value) {
    ByteData byte = ByteData(4);
    byte.setUint32(0, value, Endian.little);
    buffer.add(byte.buffer.asUint8List());
  }
}

class StringSerializer implements Serializer<String> {
  @override
  void appendByteBuffer(buffer, value) {
    List<int> bytes = utf8.encode(value);
    final length = bytes.length;
    ByteData byte = ByteData(calculateVarint32(length));
    byte.setUint8(0, length);
    buffer.add(byte.buffer.asUint8List());
    buffer.add(utf8.encode(value));
  }
}

class DateSerializer implements Serializer<String> {
  @override
  void appendByteBuffer(buffer, value) {
    if (!value.endsWith('Z')) {
      value = '${value}Z';
    }
    ByteData byte = ByteData(4);
    byte.setUint32(
        0,
        (DateTime.parse(value).millisecondsSinceEpoch / 1000).floor(),
        Endian.little);
    buffer.add(byte.buffer.asUint8List());
  }
}

class ArraySerializer implements Serializer<List<dynamic>> {
  final Serializer itemSerializer;

  ArraySerializer(this.itemSerializer);

  @override
  void appendByteBuffer(buffer, values) {
    final data = values.length;
    final size = calculateVarint32(data);
    final ByteData byte = ByteData(size);
    byte.setUint8(0, data);

    buffer.add(byte.buffer.asUint8List());
    for (final value in values) {
      itemSerializer.appendByteBuffer(buffer, value);
    }
  }
}

class ObjectSerializer implements Serializer<Map<String, dynamic>> {
  final Map<String, Serializer> keySerializers;

  ObjectSerializer(this.keySerializers);

  @override
  void appendByteBuffer(buffer, value) {
    for (final key in keySerializers.keys) {
      Serializer serializer = keySerializers[key];
      try {
        serializer.appendByteBuffer(buffer, value[key]);
      } catch (error) {
        final message = '$key: ${error.toString()}';
        throw Exception(message);
      }
    }
  }
}

class OperationSerializer implements Serializer<List<dynamic>> {
  @override
  void appendByteBuffer(buffer, operation) {
    final String operationName = operation[0];
    final serializer = OperationSerializers[operationName];
    if (serializer == null) {
      throw Exception('No serializer for operation: $operationName');
    }
    try {
      final Map<String, dynamic> operationParam = operation[1];
      serializer.appendByteBuffer(buffer, operationParam);
    } catch (error) {
      final message = '$operationName: ${error}';
      throw Exception(message);
    }
  }
}

class OperationDataSerializer implements Serializer<Map<String, dynamic>> {
  final int operationId;
  final Map<String, Serializer> definitions;
  final ObjectSerializer _objectSerializer;

  OperationDataSerializer(this.operationId, this.definitions)
      : _objectSerializer = ObjectSerializer(definitions);

  @override
  void appendByteBuffer(buffer, value) {
    final ByteData byte = ByteData(1);
    byte.setInt8(0, operationId);
    buffer.add(byte.buffer.asUint8List());
    _objectSerializer.appendByteBuffer(buffer, value);
  }
}

final Map<String, Serializer> OperationSerializers = {
  'comment': OperationDataSerializer(1, {
    'parent_author': StringSerializer(),
    'parent_permlink': StringSerializer(),
    'author': StringSerializer(),
    'permlink': StringSerializer(),
    'title': StringSerializer(),
    'body': StringSerializer(),
    'json_metadata': StringSerializer(),
  })
};

final TransactionSerializer = ObjectSerializer({
  'ref_block_num': UInt16Serializer(),
  'ref_block_prefix': UInt32Serializer(),
  'expiration': DateSerializer(),
  'operations': ArraySerializer(OperationSerializer()),
  'extensions': ArraySerializer(StringSerializer()),
});
