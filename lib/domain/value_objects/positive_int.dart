import 'package:flutter/material.dart';

@immutable
final class PositiveInt {
  const PositiveInt._(this.$1);

  final int $1;

  static PositiveInt? tryParse(int value) {
    if (value <= 0) {
      return null;
    }

    return PositiveInt._(value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is int) {
      return $1 == other;
    }

    if (other case PositiveInt(:final $1)) {
      return this.$1 == $1;
    }

    return false;
  }

  @override
  int get hashCode => $1.hashCode;

  @override
  String toString() {
    return $1.toString();
  }
}
