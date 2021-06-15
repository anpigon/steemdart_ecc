import 'package:test/test.dart';

import 'package:steemdart_ecc/steemdart_ecc.dart';

void main() {
  final client = Client('https://api.steemit.com');

  group('database api', () {
    test('getAccounts', () async {
      final username = 'anpigon';
      final result = await client.database.getAccounts([username]);
      assert(result.isNotEmpty);
      expect(result[0].name, username);
    }, skip: false);

    test('getAccounts', () async {
      final username = 'guest123';
      final result = await client.database.getAccounts([username]);
      assert(result.isNotEmpty);
      expect(result[0].name, username);
    }, skip: false);

    test('getAccounts', () async {
      final username = 'steemchiller';
      final result = await client.database.getAccounts([username]);
      assert(result.isNotEmpty);
      expect(result[0].name, username);
    }, skip: false);

    test('getAccounts', () async {
      final username = 'justyy';
      final result = await client.database.getAccounts([username]);
      assert(result.isNotEmpty);
      expect(result[0].name, username);
    }, skip: false);

    test('getAccounts', () async {
      final username = 'steem-agora';
      final result = await client.database.getAccounts([username]);
      assert(result.isNotEmpty);
      expect(result[0].name, username);
    }, skip: false);

    test('getAccounts', () async {
      final username = 'superman';
      final result = await client.database.getAccounts([username]);
      assert(result.isNotEmpty);
      expect(result[0].name, username);
    });

    test('getChainProperties', () async {
      final result = await client.database.getChainProperties();
      print(result.toJson());
    });

    test('getState', () async {
      final result = await client.database.getState('trending/travel');
      print(result);
    });

    test('getState 2', () async {
      final result = await client.database.getState('@almost-digital');
      print(result);
    });

    test('getVestingDelegations', () async {
      final result = await client.database.getVestingDelegations('anpigon');
      print(result[0].toJson());
    });

    test('getConfig', () async {
      final result = await client.database.getConfig();
      print(result);
    });

    test('getBlockHeader', () async {
      final result = await client.database.getBlockHeader(54652519);
      print(result.toJson());
    });
  });
}
