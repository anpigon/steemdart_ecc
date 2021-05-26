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
    });
  });
}
