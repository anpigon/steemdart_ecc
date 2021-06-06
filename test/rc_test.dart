import 'package:steemdart_ecc/src/models/rc_params.dart';
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
      assert(result is RCParams);
    });

    test('getResourcePool', () async {
      final result = await client.rc.getResourcePool();
      print(result.toJson());
      assert(result is RCPool);
    });
  });
}
