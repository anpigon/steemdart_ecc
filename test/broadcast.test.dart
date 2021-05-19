import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;

import '../lib/steemdart_ecc.dart';
import '../lib/src/helpers/utils.dart';

void main() {
  load();

  final client = Client('https://api.steemit.com');
  final TEST_ACCOUNT = env['TEST_ACCOUNT'];
  final TEST_POSTING_KEY = env['TEST_POSTING_KEY'];

  group('broadcast api', () {
    test('should broadcast comment', () async {
      final key = SteemPrivateKey.fromString(TEST_POSTING_KEY);
      final postPermlink =
          'dart-steem-test-${getRandomString(7).toLowerCase()}';
      final body =
          '![picture](https://unsplash.it/1200/800?image=${~~(Random().nextDouble() * 1085).floor()})';
      final result = await client.broadcast.comment({
        'parent_author': '',
        'parent_permlink': 'test',
        'author': TEST_ACCOUNT,
        'permlink': postPermlink,
        'title':
            'Picture of the day #${~~(Random().nextDouble() * 1e8).floor()}',
        'body': body,
        'json_metadata': json.encode({
          'tags': ['test']
        }),
      }, key);
      assert(result['result'] != null && result['result']['id'] != null);
    });
  });
}
