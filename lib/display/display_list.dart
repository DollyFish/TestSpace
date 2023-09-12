import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/launch_model.dart';

class DisplayLaunchList extends StatefulWidget {
  final List<Launch> data;
  const DisplayLaunchList({super.key, required this.data});

  @override
  State<DisplayLaunchList> createState() => _DisplayLaunchListState();
}

class _DisplayLaunchListState extends State<DisplayLaunchList> {
  late List<Launch> filteredData;
  final searchController = TextEditingController();

  @override
  void initState() {
    filteredData = widget.data;
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
          ? widget.data
          : widget.data
              .where((item) =>
                  item.name.toLowerCase().contains(text.toLowerCase()))
              .toList();
    });
  }

  int _currentSortColumn = 0;
  bool _isAscending = true;

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
      SizedBox(
        width: double.infinity,
        child: DataTable(
          columnSpacing: 22,
          dataRowHeight: 80,
          sortColumnIndex: _currentSortColumn,
          sortAscending: _isAscending,
          columns: <DataColumn>[
            const DataColumn(label: Text('Icon')),
            DataColumn(
                label: const Text('Name'),
                onSort: (columnIndex, _) {
                  setState(() {
                    _currentSortColumn = columnIndex;
                    if (_isAscending == true) {
                      _isAscending = false;
                      // sort the name in Ascending, order by A to Z
                      widget.data.sort((a, b) => a.name.compareTo(b.name));
                    } else {
                      _isAscending = true;
                      // sort the name in Ascending, order by A to Z
                      widget.data.sort((a, b) => b.name.compareTo(a.name));
                    }
                  });
                }),
            DataColumn(
              label: const Text('Launch Date'),
              numeric: true,
              onSort: (columnIndex, _) {
                setState(() {
                  _currentSortColumn = columnIndex;
                  if (_isAscending == true) {
                    _isAscending = false;
                    // sort datetime
                    widget.data.sort((a, b) => DateTime.parse(a.time)
                        .compareTo(DateTime.parse(b.time)));
                  } else {
                    _isAscending = true;
                    // sort datetime
                    widget.data.sort((a, b) => DateTime.parse(b.time)
                        .compareTo(DateTime.parse(a.time)));
                  }
                });
              },
            ),
            const DataColumn(
              label: Text('Success'),
            ),
          ],
          rows: List.generate(filteredData.length, (index) {
            final Launch item = filteredData[index];
            return DataRow(
              cells: [
                DataCell(SizedBox(
                  width: 50,
                  child: Image.network(item.image),
                )),
                DataCell(SizedBox(
                    width: 70,
                    child: Text(
                      item.name,
                      overflow: TextOverflow.clip,
                    ))),
                DataCell(Text(DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(item.time)))),
                if (item.success != null)
                  DataCell(Text(
                    item.success! ? 'success' : 'fail',
                    style: TextStyle(
                        color: item.success! ? Colors.green : Colors.red),
                  ))
                else
                  const DataCell(Text('No data'))
              ],
            );
          }),
        ),
      ),
    ]);
  }
}
