import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/value_objects/cat_tag.dart';
import '../../../providers/cat_request_provider.dart';
import '../../../providers/project_providers.dart';
import '../../neu_dropdown.dart';
import 'cat_tag_text_field.dart';

class CatTagsTypeAheadField extends HookConsumerWidget {
  const CatTagsTypeAheadField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final catTags = useFuture(ref.watch(catTagsProvider)).data ?? IList();

    return TypeAheadField<CatTag>(
      hideOnEmpty: true,
      hideOnLoading: true,
      debounceDuration: Duration.zero,
      suggestionsCallback: (search) => _optionsBuilder(catTags, search),
      onSelected: (tag) {
        ref.read(catIdentifierNotifierProvider.notifier).addCatTag(tag);
        controller.clear();
      },
      builder: _fieldViewBuilder,
      itemBuilder: (_, tag) => ListTile(title: Text(tag.$1)),
      listBuilder: (context, children) => NeuDropdown(children: children),
    );
  }

  Widget _fieldViewBuilder(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CatTagTextField(
        controller: textEditingController,
        focusNode: focusNode,
        hintText: 'Tags',
      ),
    );
  }

  List<CatTag> _optionsBuilder(IList<CatTag> tags, String text) {
    if (tags.isEmpty) {
      return const [];
    }

    final lowerCase = text.toLowerCase();

    return tags
        .where((tag) => tag.$1.toLowerCase().contains(lowerCase))
        .toList();
  }
}
