import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../../../../domain/value_objects/cat_tag.dart';
import '../../../providers/cat_request_provider.dart';

class CatTagPill extends ConsumerWidget {
  const CatTagPill({
    required this.tag,
    required this.color,
    super.key,
  });

  final CatTag tag;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(catIdentifierNotifierProvider.notifier).removeCatTag(tag);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(1000),
          border: Border.all(width: neuBorder),
          boxShadow: const [
            BoxShadow(
              blurStyle: neuBlurStyle,
              color: neuShadow,
              offset: neuOffset,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(tag.$1, style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.remove_circle_outline),
            ],
          ),
        ),
      ),
    );
  }
}
