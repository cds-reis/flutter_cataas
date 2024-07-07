import 'package:flutter/material.dart';

import '../../service_locator.dart';
import '../extensions/build_context_extensions.dart';
import 'cat_tags_display.dart';
import 'cat_tags_type_ahead_field.dart';

class CatFiltersDrawer extends StatelessWidget {
  const CatFiltersDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.height * .01),
              const Text(
                'Customize your cat!',
                style: TextStyle(fontSize: 24),
              ),
              CatTagsTypeAheadField(getTagsUseCase: sl()),
              const CatTagsDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}
