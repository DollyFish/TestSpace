import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:testing/setting/bloc/language_cubit.dart';
import 'package:testing/setting/constance/language_constance.dart';

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
        body: BlocBuilder<LanguageCubit, bool>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocale.language.getString(context),
                      style: const TextStyle(fontSize: 15)),
                  Switch(
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
                      }),
                ],
              ),
            );
          },
        ));
  }
}
