import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_models.freezed.dart';

@freezed
abstract class KeyInput with _$KeyInput {
  const factory KeyInput(
    PhysicalKeyboardKey key, {
    @Default(false) bool isControl,
    @Default(false) bool isMeta,
    @Default(false) bool isShift,
    @Default(false) bool isAlt,
  }) = _KeyInput;
}
