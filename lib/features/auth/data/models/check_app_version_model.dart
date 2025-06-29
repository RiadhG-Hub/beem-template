import 'package:dart_mappable/dart_mappable.dart';

part 'check_app_version_model.mapper.dart';

@MappableClass()
class CheckAppVersionModel {
  @MappableField(key: 'ErrorMessage')
  String ErrorMessage;
  @MappableField(key: 'VNumber')
  String VNumber;
  @MappableField(key: 'Status')
  int Status;
  @MappableField(key: 'Link')
  dynamic Link;
  @MappableField(key: 'Type')
  String Type;

  CheckAppVersionModel(
      this.ErrorMessage, this.VNumber, this.Status, this.Link, this.Type);

  factory CheckAppVersionModel.fromJson(Map<String, dynamic> map) =>
      _ensureContainer.fromMap<CheckAppVersionModel>(map);

  factory CheckAppVersionModel.fromString(String json) =>
      _ensureContainer.fromJson<CheckAppVersionModel>(json);

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

  CheckAppVersionModelCopyWith<CheckAppVersionModel, CheckAppVersionModel,
      CheckAppVersionModel> get copyWith {
    return _CheckAppVersionModelCopyWithImpl(this, $identity, $identity);
  }

  static final MapperContainer _ensureContainer = () {
    CheckAppVersionModelMapper.ensureInitialized();
    return MapperContainer.globals;
  }();

  static CheckAppVersionModelMapper ensureInitialized() =>
      CheckAppVersionModelMapper.ensureInitialized();
}
