part of 'main_cat_cubit.dart';

sealed class MainCatState extends Equatable {
  const MainCatState();

  @override
  List<Object?> get props => [];
}

final class MainCatLoading extends MainCatState {
  const MainCatLoading();
}

final class MainCatSucess extends MainCatState {
  const MainCatSucess(this.cat);

  final Cat cat;

  @override
  List<Object?> get props => [cat];
}

final class MainCatFailure extends MainCatState {
  const MainCatFailure(this.failure);

  final AppFailure failure;

  @override
  List<Object?> get props => [failure];
}
