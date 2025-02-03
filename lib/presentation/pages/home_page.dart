import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';
import '../widgets/cat_request_builder/cat_customization_display.dart';
import 'main_cat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.title),
        actions: [
          Builder(
            builder: (context) {
              if (context.width > 900) {
                return const SizedBox.shrink();
              }

              return IconButton(
                icon: const Icon(Icons.tune_outlined),
                onPressed: () => context.scaffold.openEndDrawer(),
              );
            },
          ),
          // LayoutBuilder(
          //   builder: (_, constrains) {
          //     return SizedBox(width: constrains.maxWidth * .045);
          //   },
          // ),
        ],
      ),
      body: const MainCatPage(),
      endDrawer: switch (context.width) {
        <= 900 => const Drawer(
            child: CatFiltersDisplay(),
          ),
        _ => null,
      },
    );
  }
}
