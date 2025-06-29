// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'verify_captcha_model.dart';

class VerifyCaptchaModelMapper extends ClassMapperBase<VerifyCaptchaModel> {
  VerifyCaptchaModelMapper._();

  static VerifyCaptchaModelMapper? _instance;
  static VerifyCaptchaModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VerifyCaptchaModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VerifyCaptchaModel';

  static String _$Status(VerifyCaptchaModel v) => v.Status;
  static const Field<VerifyCaptchaModel, String> _f$Status =
      Field('Status', _$Status);
  static String _$ErrorMessage(VerifyCaptchaModel v) => v.ErrorMessage;
  static const Field<VerifyCaptchaModel, String> _f$ErrorMessage =
      Field('ErrorMessage', _$ErrorMessage);
  static String _$CaptchaString(VerifyCaptchaModel v) => v.CaptchaString;
  static const Field<VerifyCaptchaModel, String> _f$CaptchaString =
      Field('CaptchaString', _$CaptchaString);

  @override
  final MappableFields<VerifyCaptchaModel> fields = const {
    #Status: _f$Status,
    #ErrorMessage: _f$ErrorMessage,
    #CaptchaString: _f$CaptchaString,
  };

  static VerifyCaptchaModel _instantiate(DecodingData data) {
    return VerifyCaptchaModel(data.dec(_f$Status), data.dec(_f$ErrorMessage),
        data.dec(_f$CaptchaString));
  }

  @override
  final Function instantiate = _instantiate;

  static VerifyCaptchaModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VerifyCaptchaModel>(map);
  }

  static VerifyCaptchaModel fromJson(String json) {
    return ensureInitialized().decodeJson<VerifyCaptchaModel>(json);
  }
}

mixin VerifyCaptchaModelMappable {
  String toJson() {
    return VerifyCaptchaModelMapper.ensureInitialized()
        .encodeJson<VerifyCaptchaModel>(this as VerifyCaptchaModel);
  }

  Map<String, dynamic> toMap() {
    return VerifyCaptchaModelMapper.ensureInitialized()
        .encodeMap<VerifyCaptchaModel>(this as VerifyCaptchaModel);
  }

  VerifyCaptchaModelCopyWith<VerifyCaptchaModel, VerifyCaptchaModel,
          VerifyCaptchaModel>
      get copyWith => _VerifyCaptchaModelCopyWithImpl<VerifyCaptchaModel,
          VerifyCaptchaModel>(this as VerifyCaptchaModel, $identity, $identity);
  @override
  String toString() {
    return VerifyCaptchaModelMapper.ensureInitialized()
        .stringifyValue(this as VerifyCaptchaModel);
  }

  @override
  bool operator ==(Object other) {
    return VerifyCaptchaModelMapper.ensureInitialized()
        .equalsValue(this as VerifyCaptchaModel, other);
  }

  @override
  int get hashCode {
    return VerifyCaptchaModelMapper.ensureInitialized()
        .hashValue(this as VerifyCaptchaModel);
  }
}

extension VerifyCaptchaModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VerifyCaptchaModel, $Out> {
  VerifyCaptchaModelCopyWith<$R, VerifyCaptchaModel, $Out>
      get $asVerifyCaptchaModel => $base.as(
          (v, t, t2) => _VerifyCaptchaModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VerifyCaptchaModelCopyWith<$R, $In extends VerifyCaptchaModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? Status, String? ErrorMessage, String? CaptchaString});
  VerifyCaptchaModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _VerifyCaptchaModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VerifyCaptchaModel, $Out>
    implements VerifyCaptchaModelCopyWith<$R, VerifyCaptchaModel, $Out> {
  _VerifyCaptchaModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VerifyCaptchaModel> $mapper =
      VerifyCaptchaModelMapper.ensureInitialized();
  @override
  $R call({String? Status, String? ErrorMessage, String? CaptchaString}) =>
      $apply(FieldCopyWithData({
        if (Status != null) #Status: Status,
        if (ErrorMessage != null) #ErrorMessage: ErrorMessage,
        if (CaptchaString != null) #CaptchaString: CaptchaString
      }));
  @override
  VerifyCaptchaModel $make(CopyWithData data) => VerifyCaptchaModel(
      data.get(#Status, or: $value.Status),
      data.get(#ErrorMessage, or: $value.ErrorMessage),
      data.get(#CaptchaString, or: $value.CaptchaString));

  @override
  VerifyCaptchaModelCopyWith<$R2, VerifyCaptchaModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _VerifyCaptchaModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
