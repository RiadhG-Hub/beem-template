sealed class SettingsState {}

class SettingsStateInit extends SettingsState {
  final String? baseUrl;

  SettingsStateInit(this.baseUrl);

  @override
  String toString() {
    return baseUrl ?? "";
  }
}

class UpdateBaseUrlSuccessState extends SettingsState {
  final String? baseUrl;

  UpdateBaseUrlSuccessState(this.baseUrl);

  @override
  String toString() {
    return baseUrl ?? "";
  }
}

class UpdateBaseUrlFailedState extends SettingsState {
  final String? baseUrl;

  UpdateBaseUrlFailedState(this.baseUrl);

  @override
  String toString() {
    return baseUrl ?? "";
  }
}

class FetchBaseUrlResultState extends SettingsState {
  final String? baseUrl;

  FetchBaseUrlResultState(this.baseUrl);

  @override
  String toString() {
    return baseUrl ?? "";
  }
}
