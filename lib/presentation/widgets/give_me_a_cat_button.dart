import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../extensions/build_context_extensions.dart';
import '../providers/main_cat_provider.dart';

class GiveMeACatButton extends ConsumerWidget {
  const GiveMeACatButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NeuTextButton(
      enableAnimation: true,
      onPressed: () {
        ref.read(mainCatProvider.notifier).getCat();
      },
      text: Text(
        context.l10n.giveMeACat,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}
