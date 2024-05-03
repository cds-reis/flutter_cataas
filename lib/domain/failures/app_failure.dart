import 'package:equatable/equatable.dart';

sealed class AppFailure extends Equatable {
  const AppFailure();

  // ignore: avoid_returning_this
  AppFailure downcast() => this;

  @override
  List<Object?> get props => [];
}

final class ApiCallFailure extends AppFailure {
  const ApiCallFailure();
}

final class ParseFailure<T> extends AppFailure {
  const ParseFailure(this.error);

  final T error;

  @override
  List<Object?> get props => [error];
}

final class NoInternetConnectionFailure extends AppFailure {
  const NoInternetConnectionFailure();
}

sealed class CacheFailure extends AppFailure {
  const CacheFailure();
}

final class EmptyCacheFailure extends CacheFailure {
  const EmptyCacheFailure();
}

final class ExpiredCacheFailure extends CacheFailure {
  const ExpiredCacheFailure();
}

final class CacheLoadFailure extends CacheFailure {
  const CacheLoadFailure({required this.error, required this.stackTrace});

  final Object error;
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [error, stackTrace];
}
