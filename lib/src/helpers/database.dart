
import '../client.dart';
import '../models/account.dart';
import '../models/block_header.dart';
import '../models/chain_properties.dart';
import '../models/dynamic_global_properties.dart';
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
          .map<VestingDelegation>((item) => VestingDelegation.from(item))
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
    return await call('get_block_header', [blockNum]).then((value) => BlockHeader.from(value['result']));
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
