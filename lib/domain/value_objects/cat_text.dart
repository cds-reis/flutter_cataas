import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

  CatText copyWith({
    NonEmptyString? text,
    ValueGetter<FontSize?>? fontSize,
    ValueGetter<FontColor?>? fontColor,
  }) {
    return CatText(
      text: text ?? this.text,
      fontSize: fontSize != null ? fontSize() : this.fontSize,
      fontColor: fontColor != null ? fontColor() : this.fontColor,
    );
  }
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
