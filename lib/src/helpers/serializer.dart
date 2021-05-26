import 'dart:convert';
import 'dart:typed_data';

int calculateVarint32(int value) {
  // ref: src/google/protobuf/io/coded_stream.cc
  value = (value & 0xffffffff) >> 0;
  if (value < 1 << 7) {
    return 1;
  } else if (value < 1 << 14) {
    return 2;
  } else if (value < 1 << 21) {
    return 3;
  } else if (value < 1 << 28) {
    return 4;
  } else {
    return 5;
  }
}

Uint8List byteVarint32(int value) {
  final byte = ByteData(calculateVarint32(value));
  var offset = 0;
  var b = 0;
  value >> 0;
  while (value >= 0x80) {
    b = (value & 0x7f) | 0x80;
    byte.setUint8(offset++, b);
    value = value >> 7;
  }
  byte.setUint8(offset++, value);
  return byte.buffer.asUint8List();
}

abstract class Serializer<T extends dynamic> {
  void appendByteBuffer(BytesBuilder buffer, T value) {}
}

class UInt16Serializer implements Serializer<int> {
  @override
  void appendByteBuffer(buffer, value) {
    final byte = ByteData(2);
    byte.setUint16(0, value, Endian.little);
    buffer.add(byte.buffer.asUint8List());
  }
}

class UInt32Serializer implements Serializer<int> {
  @override
  void appendByteBuffer(buffer, value) {
    final byte = ByteData(4);
    byte.setUint32(0, value, Endian.little);
    buffer.add(byte.buffer.asUint8List());
  }
}

class StringSerializer implements Serializer<String> {
  @override
  void appendByteBuffer(buffer, value) {
    final bytes = utf8.encode(value);
    buffer.add(byteVarint32(bytes.length));
    buffer.add(Uint8List.fromList(bytes));
  }
}

class DateSerializer implements Serializer<String> {
  @override
  void appendByteBuffer(buffer, value) {
    if (!value.endsWith('Z')) {
      value = '${value}Z';
    }
    final byte = ByteData(4);
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
    buffer.add(byteVarint32(values.length));
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
      final serializer = keySerializers[key]!;
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
      final message = '$operationName: $error';
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
    buffer.add(byteVarint32(operationId));
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
