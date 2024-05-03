import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'positive_int.dart';

sealed class CatFilter extends Equatable {
  const CatFilter();

  @override
  List<Object?> get props => [];
}

final class Mono extends CatFilter {}

final class Negate extends CatFilter {}

final class Custom extends CatFilter {
  const Custom({
    required this.brightness,
    required this.lightness,
    required this.saturation,
    required this.hue,
    required this.rgb,
  });

  final Brightness? brightness;
  final Lightness? lightness;
  final Saturation? saturation;
  final Hue? hue;
  final Rgb? rgb;

  @override
  List<Object?> get props => [
        brightness,
        lightness,
        saturation,
        hue,
        rgb,
      ];
}

final class Brightness extends Equatable {
  const Brightness(this.$1);

  final PositiveInt $1;

  @override
  List<Object?> get props => [$1];
}

final class Lightness extends Equatable {
  const Lightness(this.$1);

  final PositiveInt $1;

  @override
  List<Object?> get props => [$1];
}

final class Saturation extends Equatable {
  const Saturation(this.$1);

  final PositiveInt $1;

  @override
  List<Object?> get props => [$1];
}

final class Hue extends Equatable {
  const Hue(this.$1);

  final double $1;

  @override
  List<Object?> get props => [$1];
}

final class Rgb extends Equatable {
  const Rgb(this.$1);

  final Color $1;

  @override
  List<Object?> get props => [$1];
}
