import 'package:equatable/equatable.dart';

import 'non_empty_string.dart';
import 'positive_int.dart';

final class CatText extends Equatable {
  const CatText({
    required this.text,
    this.fontSize,
    this.fontColor,
  });

  final NonEmptyString text;
  final FontSize? fontSize;
  final FontColor? fontColor;

  @override
  List<Object?> get props => [text, fontSize, fontColor];
}

final class FontSize extends Equatable {
  const FontSize(this.$1);

  final PositiveInt $1;

  @override
  List<Object?> get props => [$1];
}

final class FontColor extends Equatable {
  const FontColor(this.$1);

  final NonEmptyString $1;

  @override
  List<Object?> get props => [$1];
}
