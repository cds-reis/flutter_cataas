import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../cubit/cat_filter_cubit/cat_filter_cubit.dart';
import '../cubit/main_cat_cubit/main_cat_cubit.dart';
import '../extensions/build_context_extensions.dart';

class GiveMeACatButton extends StatelessWidget {
  const GiveMeACatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NeuTextButton(
      enableAnimation: true,
      onPressed: () {
        final request = context.read<CatFilterCubit>().state;
        context.read<MainCatCubit>().onNewCatTap(request);
      },
      text: Text(
        context.l10n.giveMeACat,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}
