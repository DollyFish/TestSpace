import 'package:flutter/material.dart';
import 'package:testing/homepage/models/launch_model.dart';
import 'package:testing/launch_information/models/crew_model.dart';
import 'package:testing/launch_information/models/launchpad_model.dart';
import 'package:testing/launch_information/models/rocket_model.dart';

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
        border: Border.all(width: 2, color: Colors.grey),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: widgetChild,
    );
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
                child: Image(
                  image: NetworkImage(widget.launch.image['small']!),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.launch.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Text(widget.rocket.description),
            ],
          )),
          containerStyle(
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Launchpad: ${widget.launchpad.name}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'Location: ${widget.launchpad.locality} - ${widget.launchpad.region}',
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          ),
          printCrew()
        ],
      ),
    );
  }
}
