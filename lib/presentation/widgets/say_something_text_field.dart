import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../cubit/cat_filter_cubit/cat_filter_cubit.dart';
import '../extensions/build_context_extensions.dart';

class SaySomethingTextField extends StatelessWidget {
  const SaySomethingTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeuSearchBar(
          searchBarWidth: context.width,
          searchController: context.read<CatFilterCubit>().catTextController,
          hintText: context.l10n.addTextToCatInputHint,
          leadingIcon: const Icon(Icons.speaker_notes_outlined),
        ),
      ],
    );
  }
}
