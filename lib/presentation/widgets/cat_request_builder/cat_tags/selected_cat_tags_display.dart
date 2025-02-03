import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/value_objects/cat_identifier.dart';
import '../../../providers/cat_request_provider.dart';
import '../../../resources/app_colors.dart';
import 'cat_tag_pill.dart';

class SelectedCatTagsDisplay extends ConsumerWidget {
  const SelectedCatTagsDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final identifier = ref.watch(catIdentifierNotifierProvider);

    return switch (identifier) {
      CatId() || NoIdentifier() => const SizedBox.shrink(),
      Tags($1: final tags) => Wrap(
          children: tags.iter().mapIndexed(
            (index, tag) {
              final color = switch (index % 4) {
                0 => AppColors.yellow,
                1 => AppColors.green,
                2 => AppColors.orange,
                _ => AppColors.magenta,
              };

              return Padding(
                padding: const EdgeInsets.all(4),
                child: CatTagPill(tag: tag, color: color),
              );
            },
          ).toList(),
        ),
    };
  }
}
