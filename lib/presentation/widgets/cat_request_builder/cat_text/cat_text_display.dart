import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cat_font_size_picker.dart';
import 'cat_text_color_dropdown.dart';

class CatTextDisplay extends ConsumerWidget {
  const CatTextDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('Text', style: TextStyle(fontSize: 20)),
        IntrinsicHeight(
          child: Row(
            spacing: 16,
            children: [
              CatTextColorDropdown(),
              CatFontSizePicker(),
            ],
          ),
        ),
      ],
    );
  }
}
