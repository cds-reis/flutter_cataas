import 'package:equatable/equatable.dart';

sealed class CatFilter extends Equatable {
  const CatFilter();

  @override
  List<Object?> get props => [];
}

final class Blue extends CatFilter {}

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

final class Brightness {}

final class Lightness {}

final class Saturation {}

final class Hue {}

final class Rgb {}
