import 'package:e_wallet/main_cubit.dart';
import 'package:e_wallet/repositories/api/api.dart';
import 'package:e_wallet/repositories/api/api_impl.dart';
import 'package:e_wallet/repositories/log/log.dart';
import 'package:e_wallet/repositories/log/log_impl.dart';
import 'package:e_wallet/screen/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

class SimpleBlocObserver extends BlocObserver {
  final Log log;
  static const String TAG = "Bloc";

  const SimpleBlocObserver(this.log);

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    log.i(TAG, 'onCreate: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    log.i(TAG, 'onEvent: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log.i(TAG, 'onChange: ${bloc.runtimeType}, change: ${change.nextState}');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    log.i(TAG, 'onTransition: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log.i(TAG, 'onError: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log.i(TAG, 'onClose: ${bloc.runtimeType}');
  }
}

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

class Repository extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Api>(
      // create: (context) => ApiServerImpl(context.read<Log>()),
      create: (context) => ApiImpl(context.read<Log>()),
      child: Provider(),
    );
  }
}

class Provider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      );
    }));
  }
}
