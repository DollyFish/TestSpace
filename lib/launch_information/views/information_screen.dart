import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/launch_information/bloc/information_bloc.dart';
import 'package:testing/launch_information/views/widgets/information_widget.dart';
import 'package:testing/launch_list/models/launch_model.dart';

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
