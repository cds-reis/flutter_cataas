import 'package:anyhow/base.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_tags_use_case.dart';
import '../../domain/value_objects/cat_tag.dart';

class CatTagsTextField extends StatefulWidget {
  const CatTagsTextField({
    required GetTagsUseCase getTagsUseCase,
    super.key,
  }) : _getTagsUseCase = getTagsUseCase;

  final GetTagsUseCase _getTagsUseCase;

  @override
  State<CatTagsTextField> createState() => _CatTagsTextFieldState();
}

class _CatTagsTextFieldState extends State<CatTagsTextField> {
  CatTags? _tags;

  @override
  void initState() {
    widget._getTagsUseCase(DateTime.now()).inspect((tags) {
      setState(() => _tags = tags);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<CatTag>(
      optionsBuilder: (textEditingValue) {
        final tags = _tags;
        if (tags == null || tags.isEmpty) {
          return const Iterable.empty();
        }

        return tags.where(
          (tag) => tag.$1
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase()),
        );
      },
    );
  }
}
