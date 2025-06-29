import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/features/settings/data/data_source/settings_cached_data_source.dart';
import 'package:momra/injectables.dart';

@singleton
@injectable
class BaseUrl {
  static String urlResult = "";
  static Future<String> url() async {
    final SettingsCachedDataSource settingsCubit =
        getIt<SettingsCachedDataSource>();
    final String? cachedBaseUrl = await settingsCubit.fetchBaseUrl();
    urlResult = cachedBaseUrl ?? dotenv.env['BASE_URL']!;
    return urlResult;
  }
}
