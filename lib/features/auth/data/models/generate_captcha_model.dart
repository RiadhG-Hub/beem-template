import 'package:dart_mappable/dart_mappable.dart';

part 'generate_captcha_model.mapper.dart';

@MappableClass()
class GenerateCaptchaModel {
  @MappableField(key: 'Status')
  String Status;
  @MappableField(key: 'ErrorMessage')
  String ErrorMessage;
  @MappableField(key: 'CaptchaString')
  String CaptchaString;

  GenerateCaptchaModel(this.Status, this.ErrorMessage, this.CaptchaString);

  factory GenerateCaptchaModel.fromJson(Map<String, dynamic> map) =>
      _ensureContainer.fromMap<GenerateCaptchaModel>(map);

  factory GenerateCaptchaModel.fromString(String json) =>
      _ensureContainer.fromJson<GenerateCaptchaModel>(json);

  Map<String, dynamic> toJson() {
    return _ensureContainer.toMap(this);
  }

  @override
  String toString() {
    return _ensureContainer.toJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            _ensureContainer.isEqual(this, other));
  }

  @override
  int get hashCode {
    return _ensureContainer.hash(this);
  }

  GenerateCaptchaModelCopyWith<GenerateCaptchaModel, GenerateCaptchaModel,
      GenerateCaptchaModel> get copyWith {
    return _GenerateCaptchaModelCopyWithImpl(this, $identity, $identity);
  }

  static final MapperContainer _ensureContainer = () {
    GenerateCaptchaModelMapper.ensureInitialized();
    return MapperContainer.globals;
  }();

  static GenerateCaptchaModelMapper ensureInitialized() =>
      GenerateCaptchaModelMapper.ensureInitialized();
}
