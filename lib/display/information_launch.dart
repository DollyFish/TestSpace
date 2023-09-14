import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/model/rocket_model.dart';
import '../bloc/information_bloc/information_bloc.dart';
import '../model/crew_model.dart';
import '../model/launch_model.dart';
import '../model/launchpad_model.dart';

class InformationPage extends StatefulWidget {
  final Launch launch;
  const InformationPage({super.key, required this.launch});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  void initState() {
    BlocProvider.of<InformationBloc>(context).add(
      InformationRequest(
        rocketID: widget.launch.rocketID,
        crewList: widget.launch.crew,
        launchpadID: widget.launch.launchpadID,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
      ),
      body: BlocBuilder<InformationBloc, InformationState>(
        buildWhen: (previous, current) => previous.loading != current.loading,
        builder: (context, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!state.loading) {
            return InformationBody(
              launch: widget.launch,
              rocket: state.rocket,
              crew: state.crew,
              launchpad: state.launchpad,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class InformationBody extends StatefulWidget {
  final Launch launch;
  final Rocket rocket;
  final List<Crew> crew;
  final Launchpad launchpad;
  const InformationBody(
      {super.key,
      required this.launch,
      required this.rocket,
      required this.crew,
      required this.launchpad});

  @override
  State<InformationBody> createState() => _InformationBodyState();
}

class _InformationBodyState extends State<InformationBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 200,
          child: Image(image: NetworkImage(widget.launch.image['small'])),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.launch.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        Text('Rocket name: ${widget.rocket.name}'),
        Text(widget.rocket.description),
        Text('Launch name: ${widget.launch.name}'),
        Text('Launchpad name: ${widget.launchpad.name}'),
        Text(widget.crew.isNotEmpty
            ? 'Crew: ${widget.crew[0].name}'
            : 'Crew: No crew'),
      ],
    ));
  }
}