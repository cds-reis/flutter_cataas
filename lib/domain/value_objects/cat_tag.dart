import 'package:equatable/equatable.dart';

import 'non_empty_string.dart';

final class CatTag extends Equatable {
  const CatTag(this._$1);

  final NonEmptyString _$1;
  static CatTag? fromString(String value) {
    final nes = NonEmptyString.tryParse(value);

    if (nes != null) {
      return CatTag(nes);
    }

    return null;
  }

  String get $1 => _$1.$1;
  NonEmptyString get nonEmpty => _$1;

  @override
  List<Object?> get props => [_$1];
}
