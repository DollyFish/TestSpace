import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:testing/homepage/bloc/launch_bloc.dart';
import 'package:testing/homepage/repository/repository.dart';
import 'package:testing/homepage/views/homepage.dart';
import 'package:testing/homepage/views/launch_list_screen.dart';
import 'package:testing/launch_information/bloc/information_bloc.dart';
import 'package:testing/launch_information/repository/repository.dart';
import 'package:testing/launch_information/views/information_screen.dart';
import 'package:testing/setting/bloc/language_cubit.dart';
import 'package:testing/utility/language.dart';
import 'package:testing/setting/view/setting.dart';
import 'package:testing/theme/bloc/theme_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(ModularApp(module: AppModule(), child: const StartApp()));
}

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ThemeCubit(), child: const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _localization.init(
      mapLocales: [
        const MapLocale(
          'en',
          AppLocale.en,
          countryCode: 'US',
          fontFamily: 'Font EN',
        ),
        const MapLocale(
          'th',
          AppLocale.th,
          countryCode: 'TH',
          fontFamily: 'Font TH',
        ),
      ],
      initLanguageCode: 'en',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/list');
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp.router(
          supportedLocales: _localization.supportedLocales,
          localizationsDelegates: _localization.localizationsDelegates,
          title: 'SpaceX',
          theme: theme,
          debugShowCheckedModeBanner: false,
          routerConfig: Modular.routerConfig,
        );
      },
    );
  }
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage(), children: [
      ChildRoute(
        '/list',
        transition: TransitionType.rightToLeft,
        child: (context) => BlocProvider(
          create: (context) => LaunchBloc(
            LaunchRepository(),
          ),
          child: const LaunchListScreen(),
        ),
      ),
      ChildRoute(
        '/setting',
        transition: TransitionType.leftToRight,
        child: (context) => BlocProvider(
          create: (context) => LanguageCubit(),
          child: const Setting(),
        ),
      ),
      ChildRoute(
        '/information',
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
      )
    ]);
  }
}
