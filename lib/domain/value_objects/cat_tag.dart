import 'non_empty_string.dart';

extension type CatTag(NonEmptyString _$1) {
  static CatTag? fromString(String value) {
    final nes = NonEmptyString.tryParse(value);

    if (nes != null) {
      return CatTag(nes);
    }

    return null;
  }

  String get $1 => _$1.$1;
  NonEmptyString get nonEmpty => _$1;
}
