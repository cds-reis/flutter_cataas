import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'positive_int.dart';

sealed class CatFilter extends Equatable {
  const CatFilter();

  @override
  List<Object?> get props => [];
}

final class Mono extends CatFilter {
  const Mono();
}

final class Negate extends CatFilter {
  const Negate();
}

final class Custom extends CatFilter {
  const Custom({
    this.brightness,
    this.lightness,
    this.saturation,
    this.hue,
    this.rgb,
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

  Custom copyWith({
    ValueGetter<Brightness?>? brightness,
    ValueGetter<Lightness?>? lightness,
    ValueGetter<Saturation?>? saturation,
    ValueGetter<Hue?>? hue,
    ValueGetter<Rgb?>? rgb,
  }) {
    return Custom(
      brightness: brightness != null ? brightness() : this.brightness,
      lightness: lightness != null ? lightness() : this.lightness,
      saturation: saturation != null ? saturation() : this.saturation,
      hue: hue != null ? hue() : this.hue,
      rgb: rgb != null ? rgb() : this.rgb,
    );
  }
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
