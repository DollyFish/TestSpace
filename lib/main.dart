import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/display/information_launch.dart';
import 'API/data_repository.dart';
import 'bloc/information_bloc/information_bloc.dart';
import 'bloc/launch_bloc/launch_bloc.dart';
import 'display/homepage.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
