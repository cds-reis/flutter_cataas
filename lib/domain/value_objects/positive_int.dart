import 'package:anyhow/rust.dart';
import 'package:flutter/material.dart';

@immutable
final class PositiveInt {
  const PositiveInt._(this.$1);

  final int $1;

  static Option<PositiveInt> tryParse(int value) {
    switch (value) {
      case > 0:
        return Some(PositiveInt._(value));
      default:
        return None;
    }
  }

  @override
  int get hashCode => $1.hashCode;

  @override
  bool operator ==(Object other) {
    return switch (other) {
      _ when identical(this, other) => true,
      final int other when $1 == other => true,
      PositiveInt(:final $1) when this.$1 == $1 => true,
      _ => false,
    };
  }

  @override
  String toString() => $1.toString();
}
