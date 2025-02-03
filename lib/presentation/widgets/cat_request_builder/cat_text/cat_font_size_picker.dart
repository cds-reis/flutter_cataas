import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../../../../domain/value_objects/cat_text.dart';
import '../../../providers/cat_request_provider.dart';
import '../../../resources/app_colors.dart';

class CatFontSizePicker extends HookConsumerWidget {
  const CatFontSizePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useState<int>(0);

    return Column(
      spacing: 8,
      children: [
        const Text('Text Size', style: TextStyle(fontSize: 16)),
        NeuContainer(
          color: AppColors.lightPink,
          borderRadius: BorderRadius.circular(15),
          child: Row(
            children: [
              const Gap(12),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 30),
                child: Text(
                  _formatNumber(state.value),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              Slider(
                value: state.value.toDouble(),
                max: 100,
                thumbColor: AppColors.purple,
                onChanged: (value) {
                  state.value = value.toInt();
                  ref.read(catTextNotifierProvider.notifier).addFontSize(
                        FontSize.fromInt(state.value),
                      );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    return switch (number) {
      < 10 => '$number',
      < 100 => '$number',
      _ => '$number',
    };
  }
}
