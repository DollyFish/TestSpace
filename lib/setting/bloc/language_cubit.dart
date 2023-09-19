import 'package:bloc/bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

class LanguageCubit extends Cubit<bool> {
  LanguageCubit()
      : super((FlutterLocalization.instance.getLanguageName() == 'English')
            ? false
            : true);

  void changeLanguage() {
    emit(!state);
  }
}
