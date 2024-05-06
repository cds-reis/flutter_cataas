import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'cat_filter.dart';
import 'cat_identifier.dart';
import 'cat_text.dart';

final class CatRequest extends Equatable {
  const CatRequest({
    required this.identifier,
    this.text,
    this.filter,
  });

  static const CatRequest defaultRequest =
      CatRequest(identifier: NoIdentifier());

  final CatIdentifier identifier;
  final CatText? text;
  final CatFilter? filter;

  @override
  List<Object?> get props => [identifier, text, filter];

  CatRequest copyWith({
    CatIdentifier? identifier,
    ValueGetter<CatText?>? text,
    ValueGetter<CatFilter?>? filter,
  }) {
    return CatRequest(
      identifier: identifier ?? this.identifier,
      text: text != null ? text() : this.text,
      filter: filter != null ? filter() : this.filter,
    );
  }
}
