import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/cat_filter_providers.dart';

class CustomFilterDisplay extends ConsumerWidget {
  const CustomFilterDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(catFilterNotifierProvider);

    if (filter == null) {
      return const SizedBox.shrink();
    }

    return Container();
  }
}
