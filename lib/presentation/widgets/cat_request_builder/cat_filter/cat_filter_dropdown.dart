import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../../../../domain/value_objects/cat_filter.dart';
import '../../../providers/cat_request_provider.dart';
import '../../../resources/app_colors.dart';

class CatFilterDropdown extends ConsumerWidget {
  const CatFilterDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(catFilterNotifierProvider);

    return NeuContainer(
      child: DropdownButton<CatFilter?>(
        value: filter,
        icon: const DecoratedIcon(
          decoration: IconDecoration(border: IconBorder(width: 6)),
          icon: Icon(Icons.arrow_drop_down, color: Colors.white, size: 36),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        underline: const SizedBox(),
        elevation: 12,
        dropdownColor: AppColors.primary,
        items: const [
          (null, 'None'),
          (Mono(), 'Mono'),
          (Negate(), 'Negate'),
          (Custom(), 'Custom'),
        ].map(_toMenuItem).toList(),
        onChanged: (value) {
          ref.read(catFilterNotifierProvider.notifier).changeFilter(value);
        },
      ),
    );
  }

  DropdownMenuItem<CatFilter> _toMenuItem((CatFilter?, String) filter) =>
      DropdownMenuItem(
        value: filter.$1,
        child: Text(filter.$2),
      );
}
