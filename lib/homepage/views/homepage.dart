import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:testing/setting/constance/language_constance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocale.home.getString(context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocale.setting.getString(context),
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Modular.to.navigate('/list');
          } else if (index == 1) {
            Modular.to.navigate('/setting');
          }
        },
      ),
    );
  }
}
