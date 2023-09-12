import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../model/ship_model.dart';

part 'ship_event.dart';
part 'ship_state.dart';

class ShipBloc extends Bloc<ShipEvent, ShipState> {
  ShipBloc() : super(ShipInitial()) {
    on<ShipEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
