import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:rakshly/core/models/traffics.dart';

part 'governorate.freezed.dart';

part 'governorate.g.dart';

@freezed
class Governorate with _$Governorate {
  const factory Governorate({
    required int id,
    required String name,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'licensing_units') required List<Traffics> traffics,
  }) = _Governorate;

  factory Governorate.fromJson(Map<String, Object?> json) =>
      _$GovernorateFromJson(json);
}
