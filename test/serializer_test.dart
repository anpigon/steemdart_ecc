import 'dart:core';
import 'dart:typed_data';
import 'package:convert/convert.dart';

import 'package:test/test.dart';
import 'package:steemdart_ecc/src/helpers/serializer.dart';

void main() {
  group('Serializer', () {
    const tx = {
      'expiration': '2021-05-15T00:21:00',
      'extensions': [],
      'operations': [
        [
          'comment',
          {
            'parent_author': '',
            'parent_permlink': 'test',
            'author': 'guest123',
            'permlink': 'dsteem-test-meputja',
            'title': 'test',
            'body': 'test',
            'json_metadata': '{\"foo\":\"bar\",\"tags\":[\"test\"]}'
          }
        ]
      ],
      'ref_block_num': 10248,
      'ref_block_prefix': 2047678077
    };

    test('UInt16Serializer', () async {
      const value = 10248;
      const expected = '0828';

      final buffer = BytesBuilder();
      UInt16Serializer().appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(expected, result);
    }, skip: false);

    test('UInt32Serializer', () async {
      const value = 2047678077;
      const expected = '7d160d7a';

      final buffer = BytesBuilder();
      UInt32Serializer().appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(expected, result);
    }, skip: false);

    test('DateSerializer', () async {
      const value = '2021-05-15T00:21:00';
      const expected = 'ec139f60';

      final buffer = BytesBuilder();
      DateSerializer().appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(expected, result);
    }, skip: false);

    test('StringSerializer', () async {
      const value = '안녕하세요.이것은테스트입니다.';
      const expected =
          '2cec9588eb8595ed9598ec84b8ec9a942eec9db4eab283ec9d80ed858cec8aa4ed8ab8ec9e85eb8b88eb8ba42e';

      final buffer = BytesBuilder();
      StringSerializer().appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    }, skip: false);

    test('ArraySerializer', () async {
      const value = [];
      const expected = '00';
      final buffer = BytesBuilder();
      ArraySerializer(StringSerializer()).appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    }, skip: false);

    test('ArraySerializer', () async {
      final value = tx['operations']!;
      const expected =
          '01010004746573740867756573743132331364737465656d2d746573742d6d657075746a61047465737404746573741d7b22666f6f223a22626172222c2274616773223a5b2274657374225d7d';
      final buffer = BytesBuilder();
      ArraySerializer(OperationSerializer())
          .appendByteBuffer(buffer, value as List<dynamic>);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    }, skip: false);

    test('TransactionSerializer', () {
      const expected =
          '08287d160d7aec139f6001010004746573740867756573743132331364737465656d2d746573742d6d657075746a61047465737404746573741d7b22666f6f223a22626172222c2274616773223a5b2274657374225d7d00';
      final buffer = BytesBuilder();
      TransactionSerializer.appendByteBuffer(buffer, tx);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    }, skip: false);

    test('StringSerializer 2', () {
      final value =
          '![picture](https://unsplash.it/1200/800?image=732\n\n---\n\nCras euismod elit a lectus malesuada sodales. Nunc justo velit, vestibulum vel mattis et, ultricies in nibh. Suspendisse in sapien tellus. Nulla vel metus arcu. Vivamus risus lacus, sollicitudin in sollicitudin ultrices, gravida at metus. Etiam sagittis quis ex sit amet sagittis. Nullam nec tellus turpis. Morbi fringilla ultricies turpis, cursus posuere tortor. Morbi at tristique leo, feugiat bibendum quam.\n\n\n🐢';
      final expected =
          'd903215b706963747572655d2868747470733a2f2f756e73706c6173682e69742f313230302f3830303f696d6167653d3733320a0a2d2d2d0a0a4372617320657569736d6f6420656c69742061206c6563747573206d616c65737561646120736f64616c65732e204e756e63206a7573746f2076656c69742c20766573746962756c756d2076656c206d61747469732065742c20756c7472696369657320696e206e6962682e2053757370656e646973736520696e2073617069656e2074656c6c75732e204e756c6c612076656c206d6574757320617263752e20566976616d7573207269737573206c616375732c20736f6c6c696369747564696e20696e20736f6c6c696369747564696e20756c7472696365732c2067726176696461206174206d657475732e20457469616d20736167697474697320717569732065782073697420616d65742073616769747469732e204e756c6c616d206e65632074656c6c7573207475727069732e204d6f726269206672696e67696c6c6120756c74726963696573207475727069732c2063757273757320706f737565726520746f72746f722e204d6f72626920617420747269737469717565206c656f2c206665756769617420626962656e64756d207175616d2e0a0a0af09f90a2';
      final buffer = BytesBuilder();
      StringSerializer().appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    });

    test('OperationSerializer', () {
      final expected =
          '0100047465737408677565737431323317646172742d737465656d2d746573742d32656730766e751c50696374757265206f66207468652064617920233938313036353039d903215b706963747572655d2868747470733a2f2f756e73706c6173682e69742f313230302f3830303f696d6167653d3733320a0a2d2d2d0a0a4372617320657569736d6f6420656c69742061206c6563747573206d616c65737561646120736f64616c65732e204e756e63206a7573746f2076656c69742c20766573746962756c756d2076656c206d61747469732065742c20756c7472696369657320696e206e6962682e2053757370656e646973736520696e2073617069656e2074656c6c75732e204e756c6c612076656c206d6574757320617263752e20566976616d7573207269737573206c616375732c20736f6c6c696369747564696e20696e20736f6c6c696369747564696e20756c7472696365732c2067726176696461206174206d657475732e20457469616d20736167697474697320717569732065782073697420616d65742073616769747469732e204e756c6c616d206e65632074656c6c7573207475727069732e204d6f726269206672696e67696c6c6120756c74726963696573207475727069732c2063757273757320706f737565726520746f72746f722e204d6f72626920617420747269737469717565206c656f2c206665756769617420626962656e64756d207175616d2e0a0a0af09f90a2117b2274616773223a5b2274657374225d7d';
      final value = {
        'parent_author': '',
        'parent_permlink': 'test',
        'author': 'guest123',
        'permlink': 'dart-steem-test-2eg0vnu',
        'title': 'Picture of the day #98106509',
        'body':
            '![picture](https://unsplash.it/1200/800?image=732\n\n---\n\nCras euismod elit a lectus malesuada sodales. Nunc justo velit, vestibulum vel mattis et, ultricies in nibh. Suspendisse in sapien tellus. Nulla vel metus arcu. Vivamus risus lacus, sollicitudin in sollicitudin ultrices, gravida at metus. Etiam sagittis quis ex sit amet sagittis. Nullam nec tellus turpis. Morbi fringilla ultricies turpis, cursus posuere tortor. Morbi at tristique leo, feugiat bibendum quam.\n\n\n🐢',
        'json_metadata': '{\"tags\":[\"test\"]}'
      };
      final buffer = BytesBuilder();
      final serializer = OperationSerializers['comment'];
      serializer!.appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    });

    test('OperationSerializer: transfer', () {
      final expected =
          '0207616e7069676f6e07616e7069676f6e010000000000000003535445454d00000e7465737420746573742074657374';
      // operationId: 02
      // from: 07 616e7069676f6e
      // to: 07 616e7069676f6e
      // amount: 0100000000000000 03 535445454d0000
      // memo: 0e 7465737420746573742074657374
      final value = {
        'from': 'anpigon',
        'to': 'anpigon',
        'amount': '0.001 STEEM',
        'memo': 'test test test',
      };
      final buffer = BytesBuilder();
      final serializer = OperationSerializers['transfer'];
      serializer!.appendByteBuffer(buffer, value);
      final result = hex.encode(buffer.toBytes());
      expect(result, expected);
    });

    test('', () {
      // {expiration: 2021-06-12T11:46:27, extensions: [], operations: [[transfer, {from: wangpigon, to: wangpigon, amount: 0.001 STEEM, memo: }]], ref_block_num: 37629, ref_block_prefix: 3966266598}
    });
  });
}
