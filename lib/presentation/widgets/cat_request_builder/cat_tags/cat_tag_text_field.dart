import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../../../../domain/value_objects/cat_tag.dart';
import '../../../providers/cat_request_provider.dart';

class CatTagTextField extends ConsumerWidget {
  const CatTagTextField({
    required this.focusNode,
    required this.controller,
    this.hintText,
    super.key,
  });
  final String? hintText;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onSubmitted: (value) {
                final catTag = CatTag.fromString(value);
                if (catTag != null) {
                  ref
                      .read(catIdentifierNotifierProvider.notifier)
                      .addCatTag(catTag);
                }
              },
              focusNode: focusNode,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
