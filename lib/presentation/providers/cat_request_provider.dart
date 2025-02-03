import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/value_objects/cat_identifier.dart';
import '../../domain/value_objects/cat_request.dart';
import '../../domain/value_objects/cat_tag.dart';
import '../../domain/value_objects/cat_text.dart';
import '../../domain/value_objects/non_empty_list.dart';
import '../../domain/value_objects/positive_int.dart';
import 'cat_filter_providers.dart';
import 'project_providers.dart';

part 'cat_request_provider.g.dart';

@riverpod
CatRequest catRequest(Ref ref) {
  return CatRequest(
    identifier: ref.watch(catIdentifierNotifierProvider),
    text: ref.watch(catTextNotifierProvider),
    filter: ref.watch(catFilterNotifierProvider),
  );
}

@riverpod
class CatIdentifierNotifier extends _$CatIdentifierNotifier {
  @override
  CatIdentifier build() => const NoIdentifier();

  void useCatId(CatId id) {
    ref.read(talkerProvider).info('User asked to use cat with ID $id.');
    state = id;
  }

  void addCatTag(CatTag tag) {
    final talker = ref.read(talkerProvider)
      ..info('User submitted new cat tag: $tag');
    final currentTags = switch (state) {
      Tags($1: final tags) => tags,
      CatId() || NoIdentifier() => null,
    };
    if (currentTags == null) {
      state = Tags(NonEmptyList(tag));
    } else if (!currentTags.contains(tag)) {
      state = Tags(currentTags.append(tag));
    } else {
      talker.debug(
        '''User tried to submit tag $tag, but it was already found on the list. Current state: $state''',
      );
    }
  }

  void removeCatTag(CatTag tag) {
    final talker = ref.read(talkerProvider);
    if (state case Tags($1: final tags)) {
      talker.info('User asked to remove tag $tag');
      if (!tags.contains(tag)) {
        talker.warning(
          '''User tried to remove tag $tag, but it was not found on the list. Current state: $state''',
        );
      } else {
        final newTags = tags.remove(tag);

        state = switch (newTags) {
          NonEmptyList() => Tags(newTags),
          null => const NoIdentifier(),
        };
      }
    } else {
      talker.warning(
        '''User managed to remove a tag when the CatFilterNotifier was on a different identifier than Tags. This is likely a bug. Current state when this happened: $state. Tag user selected: $tag''',
      );
    }
  }
}

@Riverpod(keepAlive: true)
class CatTextNotifier extends _$CatTextNotifier {
  @override
  CatText build() {
    return CatText(
      text: '',
      fontColor: ref.watch(fontColorNotifierProvider),
    );
  }

  void onCatTextChange(String text) {
    ref.read(talkerProvider).info('User submitted new cat text: $text');

    state = state.copyWith(text: text);
  }

  void addFontSize(FontSize? size) {
    ref.read(talkerProvider).info('User submitted new font size: $size');
    state = state.copyWith(fontSize: () => size);
  }
}

@riverpod
class FontColorNotifier extends _$FontColorNotifier {
  @override
  FontColor build() => FontColor.white;

  void changeFontColor(FontColor color) {
    ref.read(talkerProvider).info('User submitted new font color: $color');

    state = color;
  }
}

@riverpod
class FontSizeNotifier extends _$FontSizeNotifier {
  @override
  FontSize? build() => null;

  void onFontSizeChanged(int size) {
    ref.read(talkerProvider).info('User submitted new font size: $size');

    state = switch (PositiveInt.tryParse(size).toNullable()) {
      null => null,
      final size => FontSize(size)
    };
  }
}
