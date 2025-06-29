abstract class SettingsRepos {
  Future<String> updateBaseUrl({required String baseUrl});

  Future<String?> fetchBaseUrl();

  void clearBaseUrl();
}
