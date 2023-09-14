part of 'information_bloc.dart';

@immutable
abstract class InformationEvent extends Equatable {
  const InformationEvent();
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

class InformationRequest extends InformationEvent {
  final String rocketID;
  final List crewList;
  final String launchpadID;

  const InformationRequest(
      {this.rocketID = '', this.crewList = const [], this.launchpadID = ''});

  @override
  List<Object> get props => [rocketID, crewList, launchpadID];
}
