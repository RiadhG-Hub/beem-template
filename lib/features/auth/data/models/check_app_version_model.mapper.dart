// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'check_app_version_model.dart';

class CheckAppVersionModelMapper extends ClassMapperBase<CheckAppVersionModel> {
  CheckAppVersionModelMapper._();

  static CheckAppVersionModelMapper? _instance;
  static CheckAppVersionModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CheckAppVersionModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CheckAppVersionModel';

  static String _$ErrorMessage(CheckAppVersionModel v) => v.ErrorMessage;
  static const Field<CheckAppVersionModel, String> _f$ErrorMessage =
      Field('ErrorMessage', _$ErrorMessage);
  static String _$VNumber(CheckAppVersionModel v) => v.VNumber;
  static const Field<CheckAppVersionModel, String> _f$VNumber =
      Field('VNumber', _$VNumber);
  static int _$Status(CheckAppVersionModel v) => v.Status;
  static const Field<CheckAppVersionModel, int> _f$Status =
      Field('Status', _$Status);
  static dynamic _$Link(CheckAppVersionModel v) => v.Link;
  static const Field<CheckAppVersionModel, dynamic> _f$Link =
      Field('Link', _$Link);
  static String _$Type(CheckAppVersionModel v) => v.Type;
  static const Field<CheckAppVersionModel, String> _f$Type =
      Field('Type', _$Type);

  @override
  final MappableFields<CheckAppVersionModel> fields = const {
    #ErrorMessage: _f$ErrorMessage,
    #VNumber: _f$VNumber,
    #Status: _f$Status,
    #Link: _f$Link,
    #Type: _f$Type,
  };

  static CheckAppVersionModel _instantiate(DecodingData data) {
    return CheckAppVersionModel(data.dec(_f$ErrorMessage), data.dec(_f$VNumber),
        data.dec(_f$Status), data.dec(_f$Link), data.dec(_f$Type));
  }

  @override
  final Function instantiate = _instantiate;

  static CheckAppVersionModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CheckAppVersionModel>(map);
  }

  static CheckAppVersionModel fromJson(String json) {
    return ensureInitialized().decodeJson<CheckAppVersionModel>(json);
  }
}

mixin CheckAppVersionModelMappable {
  String toJson() {
    return CheckAppVersionModelMapper.ensureInitialized()
        .encodeJson<CheckAppVersionModel>(this as CheckAppVersionModel);
  }

  Map<String, dynamic> toMap() {
    return CheckAppVersionModelMapper.ensureInitialized()
        .encodeMap<CheckAppVersionModel>(this as CheckAppVersionModel);
  }

  CheckAppVersionModelCopyWith<CheckAppVersionModel, CheckAppVersionModel,
      CheckAppVersionModel> get copyWith => _CheckAppVersionModelCopyWithImpl<
          CheckAppVersionModel, CheckAppVersionModel>(
      this as CheckAppVersionModel, $identity, $identity);
  @override
  String toString() {
    return CheckAppVersionModelMapper.ensureInitialized()
        .stringifyValue(this as CheckAppVersionModel);
  }

  @override
  bool operator ==(Object other) {
    return CheckAppVersionModelMapper.ensureInitialized()
        .equalsValue(this as CheckAppVersionModel, other);
  }

  @override
  int get hashCode {
    return CheckAppVersionModelMapper.ensureInitialized()
        .hashValue(this as CheckAppVersionModel);
  }
}

extension CheckAppVersionModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CheckAppVersionModel, $Out> {
  CheckAppVersionModelCopyWith<$R, CheckAppVersionModel, $Out>
      get $asCheckAppVersionModel => $base.as(
          (v, t, t2) => _CheckAppVersionModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CheckAppVersionModelCopyWith<
    $R,
    $In extends CheckAppVersionModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? ErrorMessage,
      String? VNumber,
      int? Status,
      dynamic Link,
      String? Type});
  CheckAppVersionModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CheckAppVersionModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CheckAppVersionModel, $Out>
    implements CheckAppVersionModelCopyWith<$R, CheckAppVersionModel, $Out> {
  _CheckAppVersionModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CheckAppVersionModel> $mapper =
      CheckAppVersionModelMapper.ensureInitialized();
  @override
  $R call(
          {String? ErrorMessage,
          String? VNumber,
          int? Status,
          Object? Link = $none,
          String? Type}) =>
      $apply(FieldCopyWithData({
        if (ErrorMessage != null) #ErrorMessage: ErrorMessage,
        if (VNumber != null) #VNumber: VNumber,
        if (Status != null) #Status: Status,
        if (Link != $none) #Link: Link,
        if (Type != null) #Type: Type
      }));
  @override
  CheckAppVersionModel $make(CopyWithData data) => CheckAppVersionModel(
      data.get(#ErrorMessage, or: $value.ErrorMessage),
      data.get(#VNumber, or: $value.VNumber),
      data.get(#Status, or: $value.Status),
      data.get(#Link, or: $value.Link),
      data.get(#Type, or: $value.Type));

  @override
  CheckAppVersionModelCopyWith<$R2, CheckAppVersionModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CheckAppVersionModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
