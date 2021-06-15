import '../client.dart';
import '../models/account.dart';
import '../models/block.dart';
import '../models/chain_properties.dart';
import '../models/comment.dart';
import '../models/dynamic_global_properties.dart';
import '../models/operation.dart';
import '../models/vesting_delegation.dart';

class DatabaseAPI {
  final Client client;

  const DatabaseAPI(this.client);

  /// Convenience for calling `database_api`.
  Future<Map<String, dynamic>> call(String method, [var params]) async {
    return client.call('condenser_api', method, params);
  }

  /// Return state of server.
  Future<DynamicGlobalProperties> getDynamicGlobalProperties() async {
    return await call('get_dynamic_global_properties')
        .then((value) => DynamicGlobalProperties.fromJson(value['result']));
  }

  /// Return median chain properties decided by witness.
  Future<ChainProperties> getChainProperties() async {
    return await call('get_chain_properties')
        .then((value) => ChainProperties.fromJson(value['result']));
  }

  /// Return all of the state required for a particular url path.
  /// @param path Path component of url conforming to condenser's scheme
  ///             e.g. `@almost-digital` or `trending/travel`
  Future<Map<String, dynamic>> getState(String path) async {
    return await call('get_state', [path]).then((value) => value['result']);
  }

  /// Get list of delegations made by account.
  /// @param account Account delegating
  /// @param from Delegatee start offset, used for paging.
  /// @param limit Number of results, max 1000.
  Future<List<VestingDelegation>> getVestingDelegations(
    String account, {
    String from = '',
    int limit = 1000,
  }) async {
    return await call('get_vesting_delegations', [account, from, limit]).then(
      (value) => value['result']
          .map<VestingDelegation>((item) => VestingDelegation.fromJson(item))
          .toList(),
    );
  }

  /// Return server config. See:
  /// https://github.com/steemit/steem/blob/master/libraries/protocol/include/steemit/protocol/config.hpp
  Future<Map<String, dynamic>> getConfig() async {
    return await call('get_config').then((value) => value['result']);
  }

  /// Return header for *blockNum*.
  Future<BlockHeader> getBlockHeader(int blockNum) async {
    return await call('get_block_header', [blockNum])
        .then((value) => BlockHeader.fromJson(value['result']));
  }

  /// Return block *blockNum*.
  Future<SignedBlock> getBlock(int blockNum) async {
    return await call('get_block', [blockNum])
        .then((value) => SignedBlock.fromJson(value['result']));
  }

  Future<List<AppliedOperation>> getOperations(int blockNum,
      {bool onlyVirtual = false}) async {
    return await call('get_ops_in_block', [blockNum, onlyVirtual]).then(
      (value) => value['result']
          .map<AppliedOperation>((item) => AppliedOperation.fromJson(item))
          .toList(),
    );
  }

  Future<List<Discussion>> getDiscussions(
    String by, {
    required String tag,
    int limit = 100, // Number of results, max 100.
    List<String>? filter_tags,
    List<String>? select_authors,
    List<String>? select_tags,
    int?
        truncate_body, // Number of bytes of post body to fetch, default 0 (all)
    String? start_author, // Name of author to start from, used for paging.
    String? start_permlink, // Permalink of post to start from, used for paging.
    String? parent_author,
    String? parent_permlink,
  }) async {
    assert([
      'active',
      'blog',
      'cashout',
      'children',
      'comments',
      'feed',
      'hot',
      'promoted',
      'trending',
      'votes',
      'created'
    ].contains(by));
    assert(limit <= 100);
    return await call('get_discussions_by_$by', [
      {
        'tag': tag,
        'limit': limit,
        'filter_tags': filter_tags,
        'select_authors': select_authors,
        'select_tags': select_tags,
        'truncate_body': truncate_body,
        'start_author': start_author,
        'start_permlink': start_permlink,
        'parent_author': parent_author,
        'parent_permlink': parent_permlink,
      }
    ]).then(
      (value) {
        print(value['result']);
        return value['result']
            .map<Discussion>((item) => Discussion.fromJson(item))
            .toList();
      }
    );
  }

  /// Return array of account info objects for the usernames passed.
  /// @param usernames The accounts to fetch.
  Future<List<Account>> getAccounts(List<String> usernames) async {
    return await call('get_accounts', [usernames]).then((value) {
      return (value['result'] as List)
          .map((account) => Account.fromJson(account))
          .toList();
    });
  }
}
