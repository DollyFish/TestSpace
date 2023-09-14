import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/API/data_repository.dart';

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

  @override
  void initState() {
    BlocProvider.of<LaunchBloc>(context).add(const LaunchRequest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SpaceX'),
        ),
        body: BlocBuilder<LaunchBloc, LaunchState>(
          buildWhen: (previous, current) => previous.loading != current.loading,
          builder: (context, state) {
            if (state.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!state.loading) {
              data = state.launch;
              return DisplayLaunchList(data: data);
            } else {
              return Container();
            }
          },
        ));
  }
}
