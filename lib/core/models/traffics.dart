import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'traffics.freezed.dart';

part 'traffics.g.dart';

@freezed
class Traffics with _$Traffics {
  const factory Traffics({
    required int id,
    required String name,
  }) = _Traffics;

  factory Traffics.fromJson(Map<String, Object?> json) =>
      _$TrafficsFromJson(json);
}
