import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/launch_bloc.dart';
import 'display/display_list.dart';
import 'model/launch_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LaunchBloc()..add(LaunchRequest()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('SpaceX'),
            ),
            body: const SingleChildScrollView(child: MyStatefulWidget()),
          ),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Launch> data = [];
  List<dynamic> filteredData = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
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
    );
  }
}
