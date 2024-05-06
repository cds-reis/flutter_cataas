import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service_locator.dart';
import '../cubit/main_cat_cubit.dart';
import '../extensions/build_context_extensions.dart';
import 'main_cat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.title)),
      body: BlocProvider(
        create: (_) => sl<MainCatCubit>()..onInit(context),
        child: const MainCatPage(),
      ),
    );
  }
}
