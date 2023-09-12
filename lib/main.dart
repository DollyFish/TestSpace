import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/display/information_launch.dart';
import 'bloc/launch_bloc.dart';
import 'display/homepage.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');
    return BlocProvider(
        create: (context) => LaunchBloc()..add(LaunchRequest()),
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: Modular.routerConfig,
        ));
  }
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.child('/page1', child: (context) => const InformationPage());
  }
}
