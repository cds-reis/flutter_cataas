import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

import '../../../domain/value_objects/cat_identifier.dart';
import '../../../domain/value_objects/cat_request.dart';
import '../../../domain/value_objects/cat_tag.dart';
import '../../../domain/value_objects/cat_text.dart';
import '../../../domain/value_objects/non_empty_list.dart';
import '../../../domain/value_objects/non_empty_string.dart';

final class CatFilterCubit extends Cubit<CatRequest> {
  CatFilterCubit({required this.talker}) : super(CatRequest.defaultRequest) {
    catTextController.addListener(_onCatTextChanged);
  }
  final Talker talker;

  final catTextController = TextEditingController();
  final catTagsController = TextEditingController();

  @override
  void onChange(Change<CatRequest> change) {
    super.onChange(change);
    talker
      ..debug('Current state for CatFilterCubit: ${change.currentState}')
      ..debug('New state for CatFilterCubit: ${change.nextState}');
  }

  void _onCatTextChanged() {
    final controllerText = catTextController.text;
    talker.info('User typed on cat text field: $controllerText');
    final text = NonEmptyString.tryParse(controllerText);
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
  }

  void onCatTagSubmitted(CatTag tag) {
    talker.info('User submitted new cat tag: $tag');
    final currentTags = switch (state.identifier) {
      Tags($1: final tags) => tags,
      CatId() || NoIdentifier() => null,
    };
    if (currentTags == null) {
      emit(state.copyWith(identifier: Tags(NonEmptyList(tag))));
    } else if (!currentTags.contains(tag)) {
      emit(state.copyWith(identifier: Tags(currentTags.append(tag))));
    } else {
      talker.debug(
        // ignore: lines_longer_than_80_chars
        'User tried to submit tag $tag, but it was already found on the list. Current state: $state',
      );
    }
    catTagsController.clear();
  }

  void onCatTagRemoved(CatTag tag) {
    if (state.identifier case Tags($1: final tags)) {
      talker.info('User asked to remove tag $tag');
      if (!tags.contains(tag)) {
        talker.warning(
          "User asked to remove tag $tag, which isn't on the list.",
        );
      }
      final newTags = tags.remove(tag);
      final identifier = switch (newTags) {
        NonEmptyList() => Tags(newTags),
        null => const NoIdentifier(),
      };
      emit(state.copyWith(identifier: identifier));
    } else {
      talker.warning(
        // ignore: lines_longer_than_80_chars
        'User managed to remove a tag when the CatFilterCubit was on a different identifier than Tags. This is likely a bug. Current state when this happened: $state. Tag user selected: $tag',
      );
    }
  }

  void onUseThisCatTap(CatId id) {
    talker.info('User asked to use cat with ID $id.');
    emit(state.copyWith(identifier: id));
  }

  void onCatTextSubmitted() {
    final identifier = state.identifier;
    final text = state.text;
    switch ((identifier, text)) {
      case (CatId(), CatText()):
    }
  }

  void onCatTextClear() {
    catTextController.clear();
  }
}
