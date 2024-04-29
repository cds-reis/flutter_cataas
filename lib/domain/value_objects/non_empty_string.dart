import 'package:meta/meta.dart';

@immutable
final class NonEmptyString {
  const NonEmptyString._(this.$1);

  final String $1;

  static NonEmptyString? tryParse(String value) {
    if (value.trim().isEmpty) {
      return null;
    }

    return NonEmptyString._(value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is String) {
      return other == $1;
    }

    if (other is NonEmptyString) {
      return other.$1 == $1;
    }

    return false;
  }

  @override
  int get hashCode => $1.hashCode;

  @override
  String toString() {
    return $1;
  }
}
