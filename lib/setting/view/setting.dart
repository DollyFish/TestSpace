import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:testing/setting/bloc/language_cubit.dart';
import 'package:testing/utility/language.dart';
import 'package:testing/theme/bloc/theme_cubit.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocale.setting.getString(context)),
        ),
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocale.language.getString(context),
                        style: const TextStyle(fontSize: 15)),
                    BlocBuilder<LanguageCubit, bool>(
                      buildWhen: (previous, current) => previous != current,
                      builder: (context, state) {
                        return Switch(
                            value: state,
                            onChanged: (bool value) {
                              setState(() {
                                context.read<LanguageCubit>().changeLanguage();
                                if (!state) {
                                  _localization.translate('th');
                                } else {
                                  _localization.translate('en');
                                }
                              });
                            });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocale.theme.getString(context),
                        style: const TextStyle(fontSize: 15)),
                    BlocBuilder<ThemeCubit, ThemeData>(
                      buildWhen: (previous, current) => previous != current,
                      builder: (context, state) {
                        return Switch(
                            value: state.brightness == Brightness.dark,
                            onChanged: (bool value) {
                              setState(() {
                                context.read<ThemeCubit>().toggleTheme();
                              });
                            });
                      },
                    ),
                  ],
                )
              ],
            )));
  }
}
