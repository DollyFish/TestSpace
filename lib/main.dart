import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/ship_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SpaceX'),
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Ship> data = [
    Ship("FalconSat", "2006-03-24T22:30:00.000Z",
        "https://images2.imgbox.com/94/f2/NN6Ph45r_o.png", false)
  ];
  List<dynamic> filteredData = [];

  final searchController = TextEditingController();

  @override
  void initState() {
    filteredData = data;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? data
          : data
              .where((item) =>
                  item.name.toLowerCase().contains(text.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(),
          ),
          onChanged: _onSearchTextChanged,
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          // width: double.infinity,
          child: DataTable(
            columnSpacing: 30,
            columns: const <DataColumn>[
              DataColumn(label: Text('Icon')),
              DataColumn(
                label: Text('Name'),
              ),
              DataColumn(
                label: Text('Launch Date'),
                numeric: true,
              ),
              DataColumn(
                label: Text('Success'),
              ),
            ],
            rows: List.generate(filteredData.length, (index) {
              final Ship item = filteredData[index];
              return DataRow(
                cells: [
                  DataCell(SizedBox(
                    width: 50,
                    child: Image.network(item.image),
                  )),
                  DataCell(Text(item.name)),
                  DataCell(Text(DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(item.time)))),
                  DataCell(Text(
                    item.success ? 'success' : 'fail',
                    style: TextStyle(
                        color: item.success ? Colors.green : Colors.red),
                  )),
                ],
              );
            }),
          ),
        ),
      ),
    ]);
  }
}
