import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/features/settings/data/data_source/settings_cached_data_source.dart';
import 'package:momra/features/settings/domain/repositories/settings_repos.dart';

@singleton
@injectable
class SettingsReposImplement extends SettingsRepos {
  final SettingsCachedDataSource cachedDataSource;

  SettingsReposImplement(this.cachedDataSource);

  @override
  Future<String> fetchBaseUrl() async {
    final cachedResult = await cachedDataSource.fetchBaseUrl();
    return cachedResult ?? dotenv.env['BASE_URL']!;
  }

  @override
  Future<String> updateBaseUrl({required String baseUrl}) {
    return cachedDataSource.updateBaseUrl(baseUrl: baseUrl);
  }

  @override
  void clearBaseUrl() async {
    return cachedDataSource.clearBaseUrl();
  }
}
