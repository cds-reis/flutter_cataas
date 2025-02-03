import 'package:flutter/material.dart';

import 'cat_tags_type_ahead_field.dart';
import 'selected_cat_tags_display.dart';

class CatTagsDisplay extends StatelessWidget {
  const CatTagsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatTagsTypeAheadField(),
        SelectedCatTagsDisplay(),
      ],
    );
  }
}
