abstract class NetworkIOService {
  Future<String> get(String url, {Map<String, String> queryParams, Map<String, String> headers});

  Future<String> post(String url, {String requestData, Map<String, String> headers});
}
