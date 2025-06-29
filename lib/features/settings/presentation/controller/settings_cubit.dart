import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momra/features/settings/data/repositories/settings_repos_impl.dart';

import 'settings_state.dart';

@injectable
@singleton
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.settingsRepos) : super(SettingsStateInit(''));
  final SettingsReposImplement settingsRepos;

  Future<void> fetchBaseUrl() async {
    try {
      final result = await settingsRepos.fetchBaseUrl();
      emit(FetchBaseUrlResultState(result));
    } catch (e) {
      emit(FetchBaseUrlResultState(null));
    }
  }

  Future<void> updateBaseUrl({required String baseUrl}) async {
    try {
      await settingsRepos.updateBaseUrl(baseUrl: baseUrl);
      emit(UpdateBaseUrlSuccessState(baseUrl));
    } catch (e) {
      emit(UpdateBaseUrlFailedState(''));
    }
  }
}
