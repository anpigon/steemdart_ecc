import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:steemdart_ecc/steemdart_ecc.dart';

void main() {
  load();

  final TEST_ACCOUNT = env['TEST_ACCOUNT'];
  final TEST_ACTIVITY_KEY = env['TEST_ACTIVITY_KEY'];

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

    test('getBlock', () async {
      final result = await client.database.getBlock(54652519);
      print(result.toJson());
    });

    test('getOperations', () async {
      final result = await client.database.getOperations(54652519);
      print(result[0].toJson());
    });

    test('getDiscussions by feed', () async {
      final result = await client.database.getDiscussions(
        'feed',
        tag: 'anpigon',
        limit: 10,
      );
      print(result[0].toJson());
    });

    test('getDiscussions by created', () async {
      final result = await client.database.getDiscussions(
        'created',
        tag: 'kr',
        limit: 10,
      );
      print(result[0].toJson());
    });

    test('verifyAuthority', () async {
      final tx = Transaction(
        ref_block_num: 0,
        ref_block_prefix: 0,
        expiration: '2000-01-01T00:00:00',
        operations: [
          Operation('custom_json', {
            'required_auths': [],
            'required_posting_auths': [TEST_ACCOUNT!],
            'id': 'rpc-params',
            'json': '{"foo": "bar"}'
          })
        ],
        extensions: [],
      );
      final key = SteemPrivateKey.fromString(TEST_ACTIVITY_KEY!);
      final stx = client.broadcast.sign(tx, key);
      final rv = await client.database.verifyAuthority(stx);
      assert(rv == true);

      final bogusKey = SteemPrivateKey.fromString(
          '5JRaypasxMx1L97ZUX7YuC5Psb5EAbF821kkAGtBj7xCJFQcbLg');
      try {
        await client.database
            .verifyAuthority(client.broadcast.sign(tx, bogusKey));
        assert(false, 'should not be reached');
      } catch (error) {
        assert(error.toString().contains('Missing Posting Authority ${TEST_ACCOUNT!}'));
      }
    });
  });
}
