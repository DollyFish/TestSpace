part of 'information_bloc.dart';

@immutable
abstract class InformationEvent {}

class InformationRequest extends InformationEvent {
  final Launch launch;

  InformationRequest(this.launch);
}
