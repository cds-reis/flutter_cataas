import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'positive_int.dart';

final class CatText extends Equatable {
  const CatText({
    required this.text,
    required this.fontColor,
    this.fontSize,
  });

  final String text;
  final FontColor fontColor;
  final FontSize? fontSize;

  @override
  List<Object?> get props => [text, fontSize, fontColor];

  CatText copyWith({
    String? text,
    FontColor? fontColor,
    ValueGetter<FontSize?>? fontSize,
  }) {
    return CatText(
      text: text ?? this.text,
      fontColor: fontColor ?? this.fontColor,
      fontSize: fontSize != null ? fontSize() : this.fontSize,
    );
  }
}

extension type const FontSize(PositiveInt _) implements PositiveInt {
  static FontSize? fromInt(int value) {
    return switch (PositiveInt.tryParse(value).toNullable()) {
      null => null,
      final positive => FontSize(positive)
    };
  }
}

typedef CSSColor = (Color color, String name);
extension type const FontColor(CSSColor value) {
  static const FontColor white = FontColor((Colors.white, 'white'));

  Color get color => value.$1;
  String get name => value.$2;
}
