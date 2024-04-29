import 'package:equatable/equatable.dart';

import 'cat_filter.dart';
import 'cat_identifier.dart';
import 'cat_text.dart';

final class CatRequest extends Equatable {
  const CatRequest({
    required this.identifier,
    this.text,
    this.filter,
  });

  final CatIdentifier identifier;
  final CatText? text;
  final CatFilter? filter;

  @override
  List<Object?> get props => [identifier, text, filter];
}
