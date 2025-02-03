import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../../../../domain/value_objects/cat_text.dart';
import '../../../providers/cat_request_provider.dart';

class CatTextColorDropdown extends ConsumerWidget {
  const CatTextColorDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fontColorNotifierProvider);

    return Column(
      spacing: 8,
      children: [
        const Text('Text Color', style: TextStyle(fontSize: 16)),
        InkWell(
          onTap: () async {
            final newColor = await showMenu<FontColor>(
              context: context,
              position: _getWidgetPosition(context),
              color: neuDefault1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(width: neuBorder),
              ),
              items: _colors.map(_toPopupMenuItem).toList(),
            );

            if (newColor != null) {
              ref
                  .read(fontColorNotifierProvider.notifier)
                  .changeFontColor(newColor);
            }
          },
          child: NeuContainer(
            borderRadius: BorderRadius.circular(12),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(spreadRadius: -8)],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ColoredBox(
                  color: state.color,
                  child: const SizedBox.square(dimension: 25),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  PopupMenuItem<FontColor> _toPopupMenuItem(FontColor color) => PopupMenuItem(
        value: color,
        child: Center(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(spreadRadius: 3)],
            ),
            child: ColoredBox(
              color: color.color,
              child: const SizedBox.square(dimension: 25),
            ),
          ),
        ),
      );

  RelativeRect _getWidgetPosition(BuildContext context) {
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final left = offset.dx;
    final top = offset.dy + renderBox.size.height;
    final right = left + renderBox.size.width;

    return RelativeRect.fromLTRB(left, top + 10, right, 0);
  }
}

const List<FontColor> _colors = [
  FontColor((CSSColors.white, 'white')),
  FontColor((CSSColors.black, 'black')),
  FontColor((CSSColors.blue, 'blue')),
  FontColor((CSSColors.brown, 'brown')),
  FontColor((CSSColors.cyan, 'cyan')),
  FontColor((CSSColors.gold, 'gold')),
  FontColor((CSSColors.gray, 'gray')),
  FontColor((CSSColors.green, 'green')),
  FontColor((CSSColors.orange, 'orange')),
  FontColor((CSSColors.pink, 'pink')),
  FontColor((CSSColors.purple, 'purple')),
  FontColor((CSSColors.red, 'red')),
  FontColor((CSSColors.silver, 'silver')),
  FontColor((CSSColors.turquoise, 'turquoise')),
  FontColor((CSSColors.violet, 'violet')),
  FontColor((CSSColors.yellow, 'yellow')),
];
