import '../client.dart';

import '../models/dynamic_global_properties.dart';

class DatabaseAPI {
  final Client client;

  const DatabaseAPI(this.client);

  Future<Map<String, dynamic>> call(String method, [var params]) async {
    return client.call('condenser_api', method, params);
  }

  Future<DynamicGlobalProperties> getDynamicGlobalProperties() async {
    return call('get_dynamic_global_properties')
        .then((value) => DynamicGlobalProperties(value));
  }
}
