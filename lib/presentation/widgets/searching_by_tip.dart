import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../../domain/value_objects/cat_identifier.dart';
import '../../domain/value_objects/cat_request.dart';
import '../../domain/value_objects/cat_tag.dart';
import '../../domain/value_objects/non_empty_list.dart';
import '../cubit/cat_filter_cubit/cat_filter_cubit.dart';
import '../resources/app_colors.dart';

class SearchingByTip extends StatelessWidget {
  const SearchingByTip({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CatFilterCubit>();

    return BlocBuilder<CatFilterCubit, CatRequest>(
      bloc: cubit,
      builder: (context, state) {
        return switch (state.identifier) {
          CatId($1: final id) => NeuContainer(
              color: AppColors.yellow,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Searching by the cat with Id $id.'),
              ),
            ),
          Tags($1: final tags) => NeuContainer(
              color: AppColors.yellow,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(_formatTagsTip(tags)),
              ),
            ),
          NoIdentifier() => const SizedBox.shrink(),
        };
      },
    );
  }

  String _formatTagsTip(NonEmptyList<CatTag> tags) {
    final formattedTags = tags.iter().map((tag) => tag.$1).join(', ');
    return 'Searching by cats with the tags: $formattedTags';
  }
}
