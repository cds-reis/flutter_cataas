import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';
import '../widgets/cat_display_frame.dart';
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
        child: ListView(
          children: const [
            CatDisplayFrame(),
            SizedBox(height: 12),
            SaySomethingTextField(),
            SizedBox(height: 12),
            GiveMeACatButton(),
            SizedBox(height: 12),
            SearchingByTip(),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
