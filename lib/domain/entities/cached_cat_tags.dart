import 'package:equatable/equatable.dart';

import '../value_objects/cached_time.dart';
import '../value_objects/cat_tag.dart';
import '../value_objects/non_empty_list.dart';

final class CachedCatTags extends Equatable {
  const CachedCatTags({required this.tags, required this.cachedTime});

  final NonEmptyList<CatTag> tags;
  final CachedTime cachedTime;

  @override
  List<Object?> get props => [tags, cachedTime];
}
