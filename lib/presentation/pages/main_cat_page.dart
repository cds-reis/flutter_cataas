import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../extensions/build_context_extensions.dart';
import '../widgets/cat_display_frame.dart';
import '../widgets/cat_request_builder/cat_customization_display.dart';
import '../widgets/give_me_a_cat_button.dart';
import '../widgets/say_something_text_field.dart';
import '../widgets/searching_by_tip.dart';

class MainCatPage extends StatelessWidget {
  const MainCatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * .045),
        child: Row(
          children: [
            Flexible(
              flex: 75,
              child: ListView(
                children: const [
                  CatDisplayFrame(),
                  Gap(12),
                  SaySomethingTextField(),
                  Gap(12),
                  GiveMeACatButton(),
                  Gap(12),
                  SearchingByTip(),
                  Gap(12),
                ],
              ),
            ),
            if (context.width > 900)
              const Flexible(
                flex: 25,
                child: CatFiltersDisplay(),
              ),
          ],
        ),
      ),
    );
  }
}
