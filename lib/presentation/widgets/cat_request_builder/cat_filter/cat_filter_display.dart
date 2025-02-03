import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cat_filter_dropdown.dart';

class CatFilterDisplay extends ConsumerWidget {
  const CatFilterDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter',
          style: TextStyle(fontSize: 20),
        ),
        CatFilterDropdown(),
      ],
    );
  }
}
