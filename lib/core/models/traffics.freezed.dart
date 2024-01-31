// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'traffics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Traffics _$TrafficsFromJson(Map<String, dynamic> json) {
  return _Traffics.fromJson(json);
}

/// @nodoc
mixin _$Traffics {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrafficsCopyWith<Traffics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrafficsCopyWith<$Res> {
  factory $TrafficsCopyWith(Traffics value, $Res Function(Traffics) then) =
      _$TrafficsCopyWithImpl<$Res, Traffics>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$TrafficsCopyWithImpl<$Res, $Val extends Traffics>
    implements $TrafficsCopyWith<$Res> {
  _$TrafficsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrafficsImplCopyWith<$Res>
    implements $TrafficsCopyWith<$Res> {
  factory _$$TrafficsImplCopyWith(
          _$TrafficsImpl value, $Res Function(_$TrafficsImpl) then) =
      __$$TrafficsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$TrafficsImplCopyWithImpl<$Res>
    extends _$TrafficsCopyWithImpl<$Res, _$TrafficsImpl>
    implements _$$TrafficsImplCopyWith<$Res> {
  __$$TrafficsImplCopyWithImpl(
      _$TrafficsImpl _value, $Res Function(_$TrafficsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$TrafficsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrafficsImpl with DiagnosticableTreeMixin implements _Traffics {
  const _$TrafficsImpl({required this.id, required this.name});

  factory _$TrafficsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrafficsImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Traffics(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Traffics'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrafficsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrafficsImplCopyWith<_$TrafficsImpl> get copyWith =>
      __$$TrafficsImplCopyWithImpl<_$TrafficsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrafficsImplToJson(
      this,
    );
  }
}

abstract class _Traffics implements Traffics {
  const factory _Traffics({required final int id, required final String name}) =
      _$TrafficsImpl;

  factory _Traffics.fromJson(Map<String, dynamic> json) =
      _$TrafficsImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$TrafficsImplCopyWith<_$TrafficsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
