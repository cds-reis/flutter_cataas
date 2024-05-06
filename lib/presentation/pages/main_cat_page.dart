import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

import '../cubit/cat_filter_cubit/cat_filter_cubit.dart';
import '../cubit/main_cat_cubit/main_cat_cubit.dart';
import '../extensions/build_context_extensions.dart';
import '../widgets/cat_display_frame.dart';
import '../widgets/say_something_text_field.dart';

class MainCatPage extends StatelessWidget {
  const MainCatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * .045),
        child: ListView(
          children: [
            const CatDisplayFrame(),
            const SizedBox(height: 12),
            const SaySomethingTextField(),
            const SizedBox(height: 12),
            NeuTextButton(
              enableAnimation: true,
              onPressed: () {
                final request = context.read<CatFilterCubit>().state;
                context.read<MainCatCubit>().onNewCatTap(request);
              },
              text: Text(
                context.l10n.giveMeACat,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
