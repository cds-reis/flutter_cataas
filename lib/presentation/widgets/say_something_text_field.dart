import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../extensions/build_context_extensions.dart';
import '../providers/cat_request_provider.dart';
import '../providers/main_cat_provider.dart';

class SaySomethingTextField extends HookConsumerWidget {
  const SaySomethingTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    useAutomaticKeepAlive();
    useEffect(() {
      textController.addListener(
        () {
          ref
              .read(catTextNotifierProvider.notifier)
              .onCatTextChange(textController.text);
        },
      );
      return null;
    });
    return NeuContainer(
      color: const Color.fromARGB(255, 214, 140, 164),
      borderRadius: BorderRadius.circular(15),
      child: Row(
        children: [
          const SizedBox(width: 6),
          const Icon(Icons.tag_outlined),
          const SizedBox(width: 13),
          Expanded(
            child: TextField(
              onSubmitted: (_) => ref.read(mainCatProvider.notifier).getCat(),
              controller: textController,
              decoration: InputDecoration(
                hintText: context.l10n.addTextToCatInputHint,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: textController.clear,
            icon: const Icon(Icons.clear_outlined),
          ),
        ],
      ),
    );
  }
}
