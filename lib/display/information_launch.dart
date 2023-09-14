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
  Widget printCrew() {
    if (widget.crew.isEmpty) {
      return containerStyle(const Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Crew:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('No crew assigned to this launch'),
          )
        ],
      ));
    } else {
      return containerStyle(Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Crew:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          for (var i = 0; i < widget.crew.length; i++)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  '${widget.crew[i].role}: ${widget.crew[i].name} - ${widget.crew[i].agency}'),
            )
        ],
      ));
    }
  }

  Widget containerStyle(widgetChild) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2, color: Colors.grey)),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: widgetChild);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        containerStyle(Row(
          children: [
            SizedBox(
              height: 100,
              child: Image(image: NetworkImage(widget.launch.image['small'])),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                widget.launch.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ],
        )),
        containerStyle(Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rocket: ${widget.rocket.name}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text(widget.rocket.description),
          ],
        )),
        containerStyle(Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Launchpad: ${widget.launchpad.name}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  'Location: ${widget.launchpad.locality} - ${widget.launchpad.region}',
                  textAlign: TextAlign.left),
            ),
          ],
        )),
        printCrew()
      ],
    ));
  }
}
