import 'package:equatable/equatable.dart';

final class NonEmptyList<T> extends Equatable {
  factory NonEmptyList(T head, [List<T>? tail]) {
    return NonEmptyList._(head: head, tail: tail ?? []);
  }

  const NonEmptyList._({required this.head, required List<T> tail})
      : _tail = tail;

  static NonEmptyList<T>? fromIterable<T>(Iterable<T> iterable) {
    if (iterable.isEmpty) {
      return null;
    }

    return NonEmptyList._(
      head: iterable.first,
      tail: iterable.skip(1).toList(),
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
