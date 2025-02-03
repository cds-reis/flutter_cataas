import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cat_filter/cat_filter_display.dart';
import 'cat_tags/cat_tags_display.dart';
import 'cat_text/cat_text_display.dart';

class CatFiltersDisplay extends ConsumerWidget {
  const CatFiltersDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                SizedBox(height: constraints.maxHeight * .01),
                const Text(
                  'Customize your cat!',
                  style: TextStyle(fontSize: 24),
                ),
                const CatTagsDisplay(),
                const CatTextDisplay(),
                const CatFilterDisplay(),
              ],
            ),
          ),
        );
      },
    );
  }
}
