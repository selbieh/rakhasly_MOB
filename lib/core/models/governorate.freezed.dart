// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'governorate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Governorate _$GovernorateFromJson(Map<String, dynamic> json) {
  return _Governorate.fromJson(json);
}

/// @nodoc
mixin _$Governorate {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'licensing_units')
  List<Traffics> get traffics => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GovernorateCopyWith<Governorate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GovernorateCopyWith<$Res> {
  factory $GovernorateCopyWith(
          Governorate value, $Res Function(Governorate) then) =
      _$GovernorateCopyWithImpl<$Res, Governorate>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'licensing_units') List<Traffics> traffics});
}

/// @nodoc
class _$GovernorateCopyWithImpl<$Res, $Val extends Governorate>
    implements $GovernorateCopyWith<$Res> {
  _$GovernorateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? traffics = null,
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
      traffics: null == traffics
          ? _value.traffics
          : traffics // ignore: cast_nullable_to_non_nullable
              as List<Traffics>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GovernorateImplCopyWith<$Res>
    implements $GovernorateCopyWith<$Res> {
  factory _$$GovernorateImplCopyWith(
          _$GovernorateImpl value, $Res Function(_$GovernorateImpl) then) =
      __$$GovernorateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'licensing_units') List<Traffics> traffics});
}

/// @nodoc
class __$$GovernorateImplCopyWithImpl<$Res>
    extends _$GovernorateCopyWithImpl<$Res, _$GovernorateImpl>
    implements _$$GovernorateImplCopyWith<$Res> {
  __$$GovernorateImplCopyWithImpl(
      _$GovernorateImpl _value, $Res Function(_$GovernorateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? traffics = null,
  }) {
    return _then(_$GovernorateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      traffics: null == traffics
          ? _value._traffics
          : traffics // ignore: cast_nullable_to_non_nullable
              as List<Traffics>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GovernorateImpl with DiagnosticableTreeMixin implements _Governorate {
  const _$GovernorateImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'licensing_units') required final List<Traffics> traffics})
      : _traffics = traffics;

  factory _$GovernorateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GovernorateImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  final List<Traffics> _traffics;
  @override
  @JsonKey(name: 'licensing_units')
  List<Traffics> get traffics {
    if (_traffics is EqualUnmodifiableListView) return _traffics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_traffics);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Governorate(id: $id, name: $name, traffics: $traffics)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Governorate'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('traffics', traffics));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GovernorateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._traffics, _traffics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_traffics));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GovernorateImplCopyWith<_$GovernorateImpl> get copyWith =>
      __$$GovernorateImplCopyWithImpl<_$GovernorateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GovernorateImplToJson(
      this,
    );
  }
}

abstract class _Governorate implements Governorate {
  const factory _Governorate(
      {required final int id,
      required final String name,
      @JsonKey(name: 'licensing_units')
      required final List<Traffics> traffics}) = _$GovernorateImpl;

  factory _Governorate.fromJson(Map<String, dynamic> json) =
      _$GovernorateImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'licensing_units')
  List<Traffics> get traffics;
  @override
  @JsonKey(ignore: true)
  _$$GovernorateImplCopyWith<_$GovernorateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
