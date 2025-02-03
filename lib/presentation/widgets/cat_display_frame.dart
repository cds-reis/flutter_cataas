import 'package:anyhow/anyhow.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../../domain/entities/cat.dart';
import '../providers/main_cat_provider.dart';
import 'cat_loader.dart';
import 'cat_widget.dart';

class CatDisplayFrame extends HookConsumerWidget {
  const CatDisplayFrame({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catFuture = ref.watch(mainCatProvider);

    return NeuContainer(
      child: FutureBuilder(
        future: catFuture,
        builder: (context, snapshot) {
          return switch (snapshot) {
            AsyncSnapshot(connectionState: ConnectionState.waiting) =>
              const CatLoader(),
            AsyncSnapshot(data: Ok(v: final Cat cat)) => CatWidget(cat: cat),
            AsyncSnapshot(data: Ok(v: null)) =>
              const Text("Sorry, we couldn't find yout cat."),
            AsyncSnapshot(data: Err()) =>
              const Text('Sorry, we had a problem fetching your cat.'),
            _ => throw UnimplementedError(),
          };
        },
      ),
    );
  }
}
