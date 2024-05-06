import 'package:anyhow/base.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cat.dart';
import '../../domain/failures/app_failure.dart';
import '../../domain/usecases/get_cat_use_case.dart';
import '../../domain/value_objects/cat_identifier.dart';
import '../../domain/value_objects/cat_request.dart';
import '../../domain/value_objects/cat_text.dart';
import '../../domain/value_objects/non_empty_string.dart';
import '../extensions/build_context_extensions.dart';

part 'main_cat_state.dart';

class MainCatCubit extends Cubit<MainCatState> {
  MainCatCubit(this._getCatUseCase) : super(const MainCatLoading());

  final GetCatUseCase _getCatUseCase;

  Future<void> onInit(BuildContext context) async {
    final text = _initialText(context);

    final request = CatRequest(
      identifier: const NoIdentifier(),
      text: CatText(text: text),
    );

    final result = await _getCatUseCase(request);
    emit(
      switch (result) {
        Ok(ok: final cat) => MainCatSucess(cat),
        Err(err: final failure) => MainCatFailure(failure),
      },
    );
  }

  Future<void> onNewCatTap() async {
    emit(const MainCatLoading());
    final result = await _getCatUseCase(
      const CatRequest(identifier: NoIdentifier()),
    );
    emit(
      switch (result) {
        Ok(ok: final cat) => MainCatSucess(cat),
        Err(err: final failure) => MainCatFailure(failure),
      },
    );
  }

  NonEmptyString _initialText(BuildContext context) =>
      NonEmptyString.tryParse(context.l10n.helloAgain) ??
      NonEmptyString.tryParse('Hello Again!')!;
}
