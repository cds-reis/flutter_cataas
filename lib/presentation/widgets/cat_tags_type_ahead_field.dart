import 'package:anyhow/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../domain/usecases/get_tags_use_case.dart';
import '../../domain/value_objects/cat_tag.dart';
import '../cubit/cat_filter_cubit/cat_filter_cubit.dart';
import 'cat_tag_text_field.dart';
import 'neu_dropdown.dart';

class CatTagsTypeAheadField extends StatefulWidget {
  const CatTagsTypeAheadField({
    required GetTagsUseCase getTagsUseCase,
    super.key,
  }) : _getTagsUseCase = getTagsUseCase;

  final GetTagsUseCase _getTagsUseCase;

  @override
  State<CatTagsTypeAheadField> createState() => _CatTagsTypeAheadFieldState();
}

class _CatTagsTypeAheadFieldState extends State<CatTagsTypeAheadField> {
  final List<CatTag> _tags = [];

  @override
  void initState() {
    widget._getTagsUseCase(DateTime.now()).inspect((tags) {
      setState(() => _tags.addAll(tags));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<CatTag>(
      hideOnEmpty: true,
      hideOnLoading: true,
      controller: context.read<CatFilterCubit>().catTagsController,
      suggestionsCallback: _optionsBuilder,
      onSelected: (tag) =>
          context.read<CatFilterCubit>().onCatTagSubmitted(tag),
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

  List<CatTag> _optionsBuilder(String text) {
    if (_tags.isEmpty) {
      return const [];
    }

    final lowerCase = text.toLowerCase();

    return _tags
        .where((tag) => tag.$1.toLowerCase().contains(lowerCase))
        .toList();
  }
}
