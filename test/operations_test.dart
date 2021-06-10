import 'dart:core';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;

import 'package:steemdart_ecc/steemdart_ecc.dart';

void main() {
  load();

  final client = Client('https://api.steemit.com');
  final TEST_ACCOUNT = env['TEST_ACCOUNT']!;
  final TEST_ACTIVITY_KEY = env['TEST_ACTIVITY_KEY']!;

  group('operations', () {
    test('should transfer steemt', () async {
      final accounts = await client.database.getAccounts([TEST_ACCOUNT]);
      final privateKey = SteemPrivateKey.fromString(TEST_ACTIVITY_KEY);
      final response = await client.broadcast.transfer({
        'from': accounts[0].name,
        'to': accounts[0].name,
        'amount': '0.001 STEEM',
        'memo': 'test test test',
      }, privateKey);
      // print(response);
    });
  });
}
