import 'package:test/test.dart';

import 'package:steemdart_ecc/steemdart_ecc.dart';

void main() {
  final client = Client('https://api.steemit.com');

  group('rc api', () {
    test('findRCAccounts', () async {
      final username = 'anpigon';
      final result = await client.rc.findRCAccounts([username]);
      print(result[0].toJson());
      assert(result.isNotEmpty);
      expect(result[0].account, username);
    });

    test('findRCAccounts', () async {
      final username = 'guest123';
      final result = await client.rc.findRCAccounts([username]);
      print(result[0].toJson());
      assert(result.isNotEmpty);
      expect(result[0].account, username);
    });

    test('getResourceParams', () async {
      final result = await client.rc.getResourceParams();
      print(result.toJson());
    });

    test('getResourcePool', () async {
      final result = await client.rc.getResourcePool();
      print(result.toJson());
    });

    test('getResourcePool', () async {
      final result = await client.rc.getResourcePool();
      print(result.toJson());
    });

    test('calculateVPMana', () async {
      const usernames = [
        'anpigon',
        'guest123',
        'steemchiller',
        'justyy',
        'steem-agora',
        'superman',
      ];
      final accounts = await client.database.getAccounts(usernames);

      for (final account in accounts) {
        final result = client.rc.calculateVPMana(account);
        print('${account.name}: ${result.percentage}');
      }
    });

    test('getVPMana', () async {
      final vpmana = await client.rc.getVPMana('steem-agora');
      print('${vpmana.percentage}');
    });

    test('getRCMana', () async {
      final rcmana = await client.rc.getRCMana('superman');
      print('${rcmana.percentage}');
    });
  });
}
