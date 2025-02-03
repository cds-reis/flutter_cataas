import 'package:anyhow/anyhow.dart';
import 'package:equatable/equatable.dart';

import '../failures/app_failure.dart';

final class NonEmptyList<T> extends Equatable {
  factory NonEmptyList(T head, [List<T>? tail]) {
    return NonEmptyList._(head: head, tail: tail ?? []);
  }

  const NonEmptyList._({required this.head, required List<T> tail})
      : _tail = tail;

  static Result<NonEmptyList<T>> fromIterable<T>(Iterable<T> iterable) {
    if (iterable.isEmpty) {
      return bail(ParseFailure(iterable));
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

  NonEmptyList<T> append(T value) {
    return NonEmptyList._(head: head, tail: [..._tail, value]);
  }

  bool contains(T element) => iter().contains(element);

  NonEmptyList<T>? remove(T element) {
    final headIsElement = head == element;
    if (headIsElement && _tail.isEmpty) {
      return null;
    }

    if (headIsElement) {
      return NonEmptyList._(head: _tail.first, tail: _tail.sublist(1));
    }

    return NonEmptyList._(head: head, tail: [..._tail]..remove(element));
  }

  @override
  List<Object?> get props => [head, _tail];
}
