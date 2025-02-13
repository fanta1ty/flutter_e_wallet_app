import 'package:e_wallet/language_cubit.dart';
import 'package:e_wallet/main_cubit.dart';
import 'package:e_wallet/repositories/bloc/bloc_observer.dart';
import 'package:e_wallet/repositories/bloc/repository.dart';
import 'package:e_wallet/repositories/log/log.dart';
import 'package:e_wallet/repositories/log/log_impl.dart';
import 'package:e_wallet/screen/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  Log log = LogImpl();
  Bloc.observer = SimpleBlocObserver(log);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    RepositoryProvider<Log>.value(
      value: log,
      child: Repository(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(builder: (context, locale) {
      return SafeArea(
          child: BlocBuilder<MainCubit, MainState>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state.themeData,
          locale: locale,
          supportedLocales: const [
            Locale('en', ''),
            Locale('vi', ''),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: Login(),
        );
      }));
    });
  }
}
