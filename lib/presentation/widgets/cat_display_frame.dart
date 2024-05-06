import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../cubit/main_cat_cubit.dart';
import 'cat_loader.dart';
import 'cat_widget.dart';

class CatDisplayFrame extends StatelessWidget {
  const CatDisplayFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return NeuContainer(
      child: BlocBuilder<MainCatCubit, MainCatState>(
        builder: (context, state) {
          return switch (state) {
            MainCatLoading() => const CatLoader(),
            MainCatSucess(:final cat) => CatWidget(cat: cat),
            MainCatFailure() =>
              const Text('Sorry, we had a problem fetching your cat.'),
          };
        },
      ),
    );
  }
}
