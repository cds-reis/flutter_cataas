import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service_locator.dart';
import '../cubit/cat_filter_cubit/cat_filter_cubit.dart';
import '../cubit/main_cat_cubit/main_cat_cubit.dart';
import '../extensions/build_context_extensions.dart';
import '../widgets/cat_filters_drawer.dart';
import 'main_cat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MainCatCubit>()..onInit(context)),
        BlocProvider(create: (_) => CatFilterCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.title),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.tune_outlined),
                  onPressed: () => context.scaffold.openEndDrawer(),
                );
              },
            ),
            SizedBox(width: context.width * .045),
          ],
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<MainCatCubit>()..onInit(context)),
            BlocProvider(create: (_) => CatFilterCubit()),
          ],
          child: const MainCatPage(),
        ),
        endDrawer: const CatFiltersDrawer(),
      ),
    );
  }
}
