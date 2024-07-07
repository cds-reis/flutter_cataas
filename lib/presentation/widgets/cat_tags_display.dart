import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../../domain/value_objects/cat_identifier.dart';
import '../../domain/value_objects/cat_request.dart';
import '../../domain/value_objects/cat_tag.dart';
import '../cubit/cat_filter_cubit/cat_filter_cubit.dart';
import '../resources/app_colors.dart';

class CatTagsDisplay extends StatelessWidget {
  const CatTagsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CatFilterCubit>();
    return BlocBuilder<CatFilterCubit, CatRequest>(
      bloc: cubit,
      builder: (context, state) {
        return switch (state.identifier) {
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
                    child: CatTagWidget(
                      tag: tag,
                      color: color,
                      onTap: cubit.onCatTagRemoved,
                    ),
                  );
                },
              ).toList(),
            ),
        };
      },
    );
  }
}

class CatTagWidget extends StatelessWidget {
  const CatTagWidget({
    required this.tag,
    required this.color,
    required this.onTap,
    super.key,
  });

  final CatTag tag;
  final Color color;
  final void Function(CatTag tag) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(tag),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(1000),
          border: Border.all(width: neuBorder),
          boxShadow: const [
            BoxShadow(
              blurStyle: neuBlurStyle,
              color: neuShadow,
              offset: neuOffset,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(tag.$1, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              const Icon(Icons.remove_circle_outline),
            ],
          ),
        ),
      ),
    );
  }
}
