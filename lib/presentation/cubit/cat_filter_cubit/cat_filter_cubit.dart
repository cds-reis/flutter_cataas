import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/value_objects/cat_request.dart';
import '../../../domain/value_objects/cat_text.dart';
import '../../../domain/value_objects/non_empty_string.dart';

final class CatFilterCubit extends Cubit<CatRequest> {
  CatFilterCubit() : super(CatRequest.defaultRequest);

  TextEditingController? _catTextController;

  TextEditingController get catTextController {
    if (_catTextController != null) {
      return _catTextController!;
    }
    _catTextController = TextEditingController();
    _catTextController?.addListener(_onCatTextChanged);
    return _catTextController!;
  }

  void _onCatTextChanged() {
    final text = NonEmptyString.tryParse(catTextController.text);
    emit(
      switch (text) {
        NonEmptyString() => state.copyWith(
            text: () => CatText(
              text: text,
              fontColor: state.text?.fontColor,
              fontSize: state.text?.fontSize,
            ),
          ),
        null => state.copyWith(text: () => null),
      },
    );
    log(state.toString());
  }
}
