import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class CustomNeuTextField extends StatelessWidget {
  const CustomNeuTextField({
    required this.controller,
    super.key,
    this.hintText,
    this.onClear,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String? hintText;
  final VoidCallback? onClear;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) {
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
              onSubmitted: (_) => onSubmitted?.call(),
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: onClear,
            icon: const Icon(Icons.clear_outlined),
          ),
        ],
      ),
    );
  }
}
