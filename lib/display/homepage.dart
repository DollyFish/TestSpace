import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/launch_bloc/launch_bloc.dart';
import '../model/launch_model.dart';
import 'display_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Launch> data = [];
  List<dynamic> filteredData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SpaceX'),
        ),
        body: BlocBuilder<LaunchBloc, LaunchState>(
          builder: (context, state) {
            if (state is LaunchLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LaunchError) {
              return Center(
                child: Text("Something went wrong ${state.message}"),
              );
            } else if (state is LaunchLoaded) {
              data = state.launch;
              return DisplayLaunchList(data: data);
            } else {
              return Container();
            }
          },
        ));
  }
}
