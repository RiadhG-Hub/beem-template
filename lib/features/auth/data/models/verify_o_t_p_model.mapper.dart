// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'verify_o_t_p_model.dart';

class VerifyOTPModelMapper extends ClassMapperBase<VerifyOTPModel> {
  VerifyOTPModelMapper._();

  static VerifyOTPModelMapper? _instance;
  static VerifyOTPModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VerifyOTPModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VerifyOTPModel';

  static String _$Status(VerifyOTPModel v) => v.Status;
  static const Field<VerifyOTPModel, String> _f$Status =
      Field('Status', _$Status);
  static String _$ErrorMessage(VerifyOTPModel v) => v.ErrorMessage;
  static const Field<VerifyOTPModel, String> _f$ErrorMessage =
      Field('ErrorMessage', _$ErrorMessage);
  static String _$CaptchaString(VerifyOTPModel v) => v.CaptchaString;
  static const Field<VerifyOTPModel, String> _f$CaptchaString =
      Field('CaptchaString', _$CaptchaString);

  @override
  final MappableFields<VerifyOTPModel> fields = const {
    #Status: _f$Status,
    #ErrorMessage: _f$ErrorMessage,
    #CaptchaString: _f$CaptchaString,
  };

  static VerifyOTPModel _instantiate(DecodingData data) {
    return VerifyOTPModel(data.dec(_f$Status), data.dec(_f$ErrorMessage),
        data.dec(_f$CaptchaString));
  }

  @override
  final Function instantiate = _instantiate;

  static VerifyOTPModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VerifyOTPModel>(map);
  }

  static VerifyOTPModel fromJson(String json) {
    return ensureInitialized().decodeJson<VerifyOTPModel>(json);
  }
}

mixin VerifyOTPModelMappable {
  String toJson() {
    return VerifyOTPModelMapper.ensureInitialized()
        .encodeJson<VerifyOTPModel>(this as VerifyOTPModel);
  }

  Map<String, dynamic> toMap() {
    return VerifyOTPModelMapper.ensureInitialized()
        .encodeMap<VerifyOTPModel>(this as VerifyOTPModel);
  }

  VerifyOTPModelCopyWith<VerifyOTPModel, VerifyOTPModel, VerifyOTPModel>
      get copyWith =>
          _VerifyOTPModelCopyWithImpl<VerifyOTPModel, VerifyOTPModel>(
              this as VerifyOTPModel, $identity, $identity);
  @override
  String toString() {
    return VerifyOTPModelMapper.ensureInitialized()
        .stringifyValue(this as VerifyOTPModel);
  }

  @override
  bool operator ==(Object other) {
    return VerifyOTPModelMapper.ensureInitialized()
        .equalsValue(this as VerifyOTPModel, other);
  }

  @override
  int get hashCode {
    return VerifyOTPModelMapper.ensureInitialized()
        .hashValue(this as VerifyOTPModel);
  }
}

extension VerifyOTPModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VerifyOTPModel, $Out> {
  VerifyOTPModelCopyWith<$R, VerifyOTPModel, $Out> get $asVerifyOTPModel =>
      $base.as((v, t, t2) => _VerifyOTPModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VerifyOTPModelCopyWith<$R, $In extends VerifyOTPModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? Status, String? ErrorMessage, String? CaptchaString});
  VerifyOTPModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _VerifyOTPModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VerifyOTPModel, $Out>
    implements VerifyOTPModelCopyWith<$R, VerifyOTPModel, $Out> {
  _VerifyOTPModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VerifyOTPModel> $mapper =
      VerifyOTPModelMapper.ensureInitialized();
  @override
  $R call({String? Status, String? ErrorMessage, String? CaptchaString}) =>
      $apply(FieldCopyWithData({
        if (Status != null) #Status: Status,
        if (ErrorMessage != null) #ErrorMessage: ErrorMessage,
        if (CaptchaString != null) #CaptchaString: CaptchaString
      }));
  @override
  VerifyOTPModel $make(CopyWithData data) => VerifyOTPModel(
      data.get(#Status, or: $value.Status),
      data.get(#ErrorMessage, or: $value.ErrorMessage),
      data.get(#CaptchaString, or: $value.CaptchaString));

  @override
  VerifyOTPModelCopyWith<$R2, VerifyOTPModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _VerifyOTPModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
