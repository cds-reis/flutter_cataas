import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../value_objects/cat_filter.dart';
import '../value_objects/cat_identifier.dart';
import '../value_objects/cat_tag.dart';
import '../value_objects/cat_text.dart';

final class Cat extends Equatable {
  const Cat({
    required this.id,
    required this.tags,
    required this.image,
    required this.text,
    required this.filter,
  });

  final CatIdentifier id;
  final Iterable<CatTag> tags;
  final Uint8List image;
  final CatText? text;
  final CatFilter? filter;

  @override
  List<Object?> get props => [
        id,
        tags,
        image,
        text,
        filter,
      ];
}
