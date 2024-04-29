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

final class ParseFailure extends AppFailure {
  const ParseFailure();
}

final class CacheFailure extends AppFailure {
  const CacheFailure();
}

final class NoInternetConnectionFailure extends AppFailure {
  const NoInternetConnectionFailure();
}
