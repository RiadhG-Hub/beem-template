// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'generate_captcha_model.dart';

class GenerateCaptchaModelMapper extends ClassMapperBase<GenerateCaptchaModel> {
  GenerateCaptchaModelMapper._();

  static GenerateCaptchaModelMapper? _instance;
  static GenerateCaptchaModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GenerateCaptchaModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GenerateCaptchaModel';

  static String _$Status(GenerateCaptchaModel v) => v.Status;
  static const Field<GenerateCaptchaModel, String> _f$Status =
      Field('Status', _$Status);
  static String _$ErrorMessage(GenerateCaptchaModel v) => v.ErrorMessage;
  static const Field<GenerateCaptchaModel, String> _f$ErrorMessage =
      Field('ErrorMessage', _$ErrorMessage);
  static String _$CaptchaString(GenerateCaptchaModel v) => v.CaptchaString;
  static const Field<GenerateCaptchaModel, String> _f$CaptchaString =
      Field('CaptchaString', _$CaptchaString);

  @override
  final MappableFields<GenerateCaptchaModel> fields = const {
    #Status: _f$Status,
    #ErrorMessage: _f$ErrorMessage,
    #CaptchaString: _f$CaptchaString,
  };

  static GenerateCaptchaModel _instantiate(DecodingData data) {
    return GenerateCaptchaModel(data.dec(_f$Status), data.dec(_f$ErrorMessage),
        data.dec(_f$CaptchaString));
  }

  @override
  final Function instantiate = _instantiate;

  static GenerateCaptchaModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GenerateCaptchaModel>(map);
  }

  static GenerateCaptchaModel fromJson(String json) {
    return ensureInitialized().decodeJson<GenerateCaptchaModel>(json);
  }
}

mixin GenerateCaptchaModelMappable {
  String toJson() {
    return GenerateCaptchaModelMapper.ensureInitialized()
        .encodeJson<GenerateCaptchaModel>(this as GenerateCaptchaModel);
  }

  Map<String, dynamic> toMap() {
    return GenerateCaptchaModelMapper.ensureInitialized()
        .encodeMap<GenerateCaptchaModel>(this as GenerateCaptchaModel);
  }

  GenerateCaptchaModelCopyWith<GenerateCaptchaModel, GenerateCaptchaModel,
      GenerateCaptchaModel> get copyWith => _GenerateCaptchaModelCopyWithImpl<
          GenerateCaptchaModel, GenerateCaptchaModel>(
      this as GenerateCaptchaModel, $identity, $identity);
  @override
  String toString() {
    return GenerateCaptchaModelMapper.ensureInitialized()
        .stringifyValue(this as GenerateCaptchaModel);
  }

  @override
  bool operator ==(Object other) {
    return GenerateCaptchaModelMapper.ensureInitialized()
        .equalsValue(this as GenerateCaptchaModel, other);
  }

  @override
  int get hashCode {
    return GenerateCaptchaModelMapper.ensureInitialized()
        .hashValue(this as GenerateCaptchaModel);
  }
}

extension GenerateCaptchaModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GenerateCaptchaModel, $Out> {
  GenerateCaptchaModelCopyWith<$R, GenerateCaptchaModel, $Out>
      get $asGenerateCaptchaModel => $base.as(
          (v, t, t2) => _GenerateCaptchaModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GenerateCaptchaModelCopyWith<
    $R,
    $In extends GenerateCaptchaModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? Status, String? ErrorMessage, String? CaptchaString});
  GenerateCaptchaModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GenerateCaptchaModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GenerateCaptchaModel, $Out>
    implements GenerateCaptchaModelCopyWith<$R, GenerateCaptchaModel, $Out> {
  _GenerateCaptchaModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GenerateCaptchaModel> $mapper =
      GenerateCaptchaModelMapper.ensureInitialized();
  @override
  $R call({String? Status, String? ErrorMessage, String? CaptchaString}) =>
      $apply(FieldCopyWithData({
        if (Status != null) #Status: Status,
        if (ErrorMessage != null) #ErrorMessage: ErrorMessage,
        if (CaptchaString != null) #CaptchaString: CaptchaString
      }));
  @override
  GenerateCaptchaModel $make(CopyWithData data) => GenerateCaptchaModel(
      data.get(#Status, or: $value.Status),
      data.get(#ErrorMessage, or: $value.ErrorMessage),
      data.get(#CaptchaString, or: $value.CaptchaString));

  @override
  GenerateCaptchaModelCopyWith<$R2, GenerateCaptchaModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _GenerateCaptchaModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
