import 'package:dart_mappable/dart_mappable.dart';

part 'verify_captcha_model.mapper.dart';

@MappableClass()
class VerifyCaptchaModel {
  @MappableField(key: 'Status')
  String Status;
  @MappableField(key: 'ErrorMessage')
  String ErrorMessage;
  @MappableField(key: 'CaptchaString')
  String CaptchaString;

  VerifyCaptchaModel(this.Status, this.ErrorMessage, this.CaptchaString);

  factory VerifyCaptchaModel.fromJson(Map<String, dynamic> map) =>
      _ensureContainer.fromMap<VerifyCaptchaModel>(map);

  factory VerifyCaptchaModel.fromString(String json) =>
      _ensureContainer.fromJson<VerifyCaptchaModel>(json);

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

  VerifyCaptchaModelCopyWith<VerifyCaptchaModel, VerifyCaptchaModel,
      VerifyCaptchaModel> get copyWith {
    return _VerifyCaptchaModelCopyWithImpl(this, $identity, $identity);
  }

  static final MapperContainer _ensureContainer = () {
    VerifyCaptchaModelMapper.ensureInitialized();
    return MapperContainer.globals;
  }();

  static VerifyCaptchaModelMapper ensureInitialized() =>
      VerifyCaptchaModelMapper.ensureInitialized();
}
