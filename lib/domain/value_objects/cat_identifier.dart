import 'package:equatable/equatable.dart';

import 'cat_tag.dart';
import 'non_empty_list.dart';

sealed class CatIdentifier extends Equatable {
  const CatIdentifier();
}

final class CatId extends CatIdentifier {
  const CatId(this.$1);
  final String $1;

  @override
  List<Object?> get props => [$1];
}

final class Tags extends CatIdentifier {
  const Tags(this.$1);
  final NonEmptyList<CatTag> $1;

  @override
  List<Object?> get props => [$1];
}

final class NoIdentifier extends CatIdentifier {
  const NoIdentifier();

  @override
  List<Object?> get props => [];
}
