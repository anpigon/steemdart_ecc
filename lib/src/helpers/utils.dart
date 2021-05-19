import 'dart:math';
import 'package:convert/convert.dart';

int parseInt(dynamic value) {
  return value is String ? int.parse(value) : value;
}

int readUInt32LE(dynamic buffer, int offset) {
  List<int> buf;
  if (buffer is String) {
    buf = hex.decode(buffer);
  } else if (buffer is List<int>) {
    buf = buffer;
  } else {
    throw Exception('error');
  }
  return int.parse(
      hex.encode(buf.sublist(offset, offset + 4).reversed.toList()),
      radix: 16);
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) {
  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
