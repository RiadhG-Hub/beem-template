import 'package:dart_mappable/dart_mappable.dart';

part 'verify_o_t_p_model.mapper.dart';

@MappableClass()
class VerifyOTPModel {
  @MappableField(key: 'Status')
  String Status;
  @MappableField(key: 'ErrorMessage')
  String ErrorMessage;
  @MappableField(key: 'CaptchaString')
  String CaptchaString;

  VerifyOTPModel(this.Status, this.ErrorMessage, this.CaptchaString);

  factory VerifyOTPModel.fromJson(Map<String, dynamic> map) =>
      _ensureContainer.fromMap<VerifyOTPModel>(map);

  factory VerifyOTPModel.fromString(String json) =>
      _ensureContainer.fromJson<VerifyOTPModel>(json);

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

  VerifyOTPModelCopyWith<VerifyOTPModel, VerifyOTPModel, VerifyOTPModel>
      get copyWith {
    return _VerifyOTPModelCopyWithImpl(this, $identity, $identity);
  }

  static final MapperContainer _ensureContainer = () {
    VerifyOTPModelMapper.ensureInitialized();
    return MapperContainer.globals;
  }();

  static VerifyOTPModelMapper ensureInitialized() =>
      VerifyOTPModelMapper.ensureInitialized();
}
