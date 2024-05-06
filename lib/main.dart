import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

import 'presentation/cubit/home_cubit/home_cubit.dart';
import 'presentation/extensions/build_context_extensions.dart';
import 'presentation/pages/home_page.dart';

void main() {
  Bloc.observer = TalkerBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.title,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomePage(),
      ),
    );
  }
}
