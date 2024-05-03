import 'package:anyhow/base.dart';
import 'package:equatable/equatable.dart';

import '../failures/app_failure.dart';

final class NonEmptyList<T> extends Equatable {
  factory NonEmptyList(T head, [List<T>? tail]) {
    return NonEmptyList._(head: head, tail: tail ?? []);
  }

  const NonEmptyList._({required this.head, required List<T> tail})
      : _tail = tail;

  static Result<NonEmptyList<T>, ParseFailure> fromIterable<T>(
    Iterable<T> iterable,
  ) {
    if (iterable.isEmpty) {
      return const Err(ParseFailure());
    }

    return Ok(
      NonEmptyList._(
        head: iterable.first,
        tail: iterable.skip(1).toList(),
      ),
    );
  }

  final T head;
  final List<T> _tail;

  Iterable<T> iter() sync* {
    yield head;
    yield* _tail;
  }

  void add(T value) {
    _tail.add(value);
  }

  @override
  List<Object?> get props => [head, _tail];
}
