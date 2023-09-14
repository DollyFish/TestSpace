import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/launch_information/views/information_screen.dart';

import 'homepage/repository/repository.dart';
import 'launch_information/bloc/information_bloc.dart';
import 'homepage/bloc/launch_bloc.dart';
import 'homepage/views/homepage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'launch_information/repository/repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
    );
  }
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => BlocProvider(
        create: (context) => LaunchBloc(
          LaunchRepository(),
        ),
        child: const HomePage(),
      ),
    );
    r.child(
      '/page1',
      transition: TransitionType.leftToRight,
      child: (context) => BlocProvider(
        create: (context) => InformationBloc(
          RocketRepository(),
          CrewRepository(),
          LaunchpadRepository(),
        ),
        child: InformationPage(
          launch: r.args.data,
        ),
      ),
    );
  }
}
