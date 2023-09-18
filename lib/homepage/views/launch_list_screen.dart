import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:testing/homepage/bloc/launch_bloc.dart';
import 'package:testing/homepage/models/launch_model.dart';
import 'package:testing/homepage/views/widgets/display_list.dart';
import 'package:testing/setting/constance/language_constance.dart';

class LaunchListScreen extends StatefulWidget {
  const LaunchListScreen({super.key});

  @override
  State<LaunchListScreen> createState() => _LaunchListScreenState();
}

class _LaunchListScreenState extends State<LaunchListScreen> {
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
          title: Text(AppLocale.title.getString(context)),
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
