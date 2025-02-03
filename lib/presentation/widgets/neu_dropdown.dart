import 'package:flutter/material.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class NeuDropdown extends StatelessWidget {
  const NeuDropdown({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: neuBorder),
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => children[index],
                childCount: children.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
