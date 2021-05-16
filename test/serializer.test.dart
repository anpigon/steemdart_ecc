import 'dart:core';
import 'dart:typed_data';
import 'package:convert/convert.dart';

import '../lib/src/helpers/serializer.dart';
import 'package:test/test.dart';

void main() {
  group('Serializer', () {
    const tx = {
      "expiration": "2021-05-15T00:21:00",
      "extensions": [],
      "operations": [
        [
          "comment",
          {
            "parent_author": "",
            "parent_permlink": "test",
            "author": "guest123",
            "permlink": "dsteem-test-meputja",
            "title": "test",
            "body": "test",
            "json_metadata": "{\"foo\":\"bar\",\"tags\":[\"test\"]}"
          }
        ]
      ],
      "ref_block_num": 10248,
      "ref_block_prefix": 2047678077
    };

    test('UInt16Serializer', () async {
      const value = 10248;
      const expected = '0828';

      BytesBuilder buffer = BytesBuilder();
      UInt16Serializer().appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(expected, result);
    }, skip: true);

    test('UInt32Serializer', () async {
      const value = 2047678077;
      const expected = '7d160d7a';

      BytesBuilder buffer = BytesBuilder();
      UInt32Serializer().appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(expected, result);
    }, skip: false);

    test('DateSerializer', () async {
      const value = "2021-05-15T00:21:00";
      const expected = 'ec139f60';

      BytesBuilder buffer = BytesBuilder();
      DateSerializer().appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(expected, result);
    }, skip: false);

    test('StringSerializer', () async {
      const value = "안녕하세요.이것은테스트입니다.";
      const expected =
          '2cec9588eb8595ed9598ec84b8ec9a942eec9db4eab283ec9d80ed858cec8aa4ed8ab8ec9e85eb8b88eb8ba42e';

      BytesBuilder buffer = BytesBuilder();
      StringSerializer().appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    }, skip: false);

    test('ArraySerializer', () async {
      const value = [];
      const expected = '00';
      BytesBuilder buffer = BytesBuilder();
      ArraySerializer(StringSerializer()).appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    }, skip: false);

    test('ArraySerializer', () async {
      final value = tx['operations'];
      const expected =
          '01010004746573740867756573743132331364737465656d2d746573742d6d657075746a61047465737404746573741d7b22666f6f223a22626172222c2274616773223a5b2274657374225d7d';
      BytesBuilder buffer = BytesBuilder();
      ArraySerializer(OperationSerializer()).appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    }, skip: false);

    test('TransactionSerializer', () {
      const expected =
          '08287d160d7aec139f6001010004746573740867756573743132331364737465656d2d746573742d6d657075746a61047465737404746573741d7b22666f6f223a22626172222c2274616773223a5b2274657374225d7d00';
      BytesBuilder buffer = BytesBuilder();
      TransactionSerializer.appendByteBuffer(buffer, tx);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    }, skip: false);
  });
}
