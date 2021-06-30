import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:buffer/buffer.dart';

import '../models/asset.dart';

int calculateVarInt32(int value) {
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

Uint8List byteVarInt32(int value) {
  final byte = ByteData(calculateVarInt32(value));
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
    if (bytes.isEmpty) {
      buffer.addByte(0);
      return;
    }
    buffer.add(byteVarInt32(bytes.length));
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
    final _value =
        (DateTime.parse(value).millisecondsSinceEpoch / 1000).floor();
    byte.setUint32(0, _value, Endian.little);
    buffer.add(byte.buffer.asInt8List());
  }
}

class ArraySerializer implements Serializer<List<dynamic>> {
  final Serializer itemSerializer;

  ArraySerializer(this.itemSerializer);

  @override
  void appendByteBuffer(buffer, values) {
    buffer.add(byteVarInt32(values.length));
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
    buffer.add(byteVarInt32(operationId));
    _objectSerializer.appendByteBuffer(buffer, value);
  }
}

/// Serialize asset.
/// @note This looses precision for amounts larger than 2^53-1/10^precision.
///       Should not be a problem in real-word usage.
class AssetSerializer implements Serializer<String> {
  @override
  void appendByteBuffer(BytesBuilder buffer, String value) {
    final asset = Asset.from(value);
    final precision = asset.getPrecision();

    final _buffer = ByteDataWriter(endian: Endian.little);
    _buffer.writeInt64((asset.amount * math.pow(10, precision)).round());
    _buffer.writeUint8(precision);
    for (var i = 0, l = asset.symbol.length; i < 7; i++) {
      _buffer.writeUint8(i < l ? asset.symbol.codeUnitAt(i) : 0);
    }

    buffer.add(_buffer.toBytes());
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
  }),
  'transfer': OperationDataSerializer(2, {
    'from': StringSerializer(),
    'to': StringSerializer(),
    'amount': AssetSerializer(),
    'memo': StringSerializer(),
  }),
  'transfer_to_vesting': OperationDataSerializer(3, {
    'from': StringSerializer(),
    'to': StringSerializer(),
    'amount': AssetSerializer(),
  }),
  'withdraw_vesting': OperationDataSerializer(4, {
    'account': StringSerializer(),
    'vesting_shares': AssetSerializer(),
  }),
  'custom_json': OperationDataSerializer(18, {
    'required_auths': ArraySerializer(StringSerializer()),
    'required_posting_auths': ArraySerializer(StringSerializer()),
    'id': StringSerializer(),
    'json': StringSerializer(),
  }),
  'delegate_vesting_shares': OperationDataSerializer(40, {
    'delegator': StringSerializer(),
    'delegatee': StringSerializer(),
    'vesting_shares': AssetSerializer(),
  }),
};

final TransactionSerializer = ObjectSerializer({
  'ref_block_num': UInt16Serializer(),
  'ref_block_prefix': UInt32Serializer(),
  'expiration': DateSerializer(),
  'operations': ArraySerializer(OperationSerializer()),
  'extensions': ArraySerializer(StringSerializer()),
});
