import 'package:equatable/equatable.dart';

import '../../domain/value_objects/cat_identifier.dart';
import '../../domain/value_objects/cat_tag.dart';

final class CatIdWithTags extends Equatable {
  const CatIdWithTags({required this.id, required this.tags});

  final CatId id;
  final Iterable<CatTag> tags;

  @override
  List<Object> get props => [id, tags];
}
