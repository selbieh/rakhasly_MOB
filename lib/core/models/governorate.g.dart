// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governorate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GovernorateImpl _$$GovernorateImplFromJson(Map<String, dynamic> json) =>
    _$GovernorateImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      traffics: (json['traffics'] as List<dynamic>)
          .map((e) => Traffics.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GovernorateImplToJson(_$GovernorateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'traffics': instance.traffics,
    };
