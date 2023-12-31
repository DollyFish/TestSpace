import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:testing/homepage/models/launch_model.dart';
import 'package:testing/utility/language.dart';

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
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(
          () {
            filteredData = text.isEmpty
                ? widget.data
                : widget.data
                    .where((item) =>
                        item.name.toLowerCase().contains(text.toLowerCase()))
                    .toList();
          },
        );
      },
    );
  }

  int _currentSortColumn = 0;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: '${AppLocale.search.getString(context)}...',
              border: const OutlineInputBorder(),
            ),
            onChanged: _onSearchTextChanged,
          ),
        ),
        DataTable(
            columnSpacing: 22,
            sortColumnIndex: _currentSortColumn,
            sortAscending: _isAscending,
            columns: <DataColumn>[
              DataColumn(
                  label: SizedBox(
                width: 50,
                child: Text(
                  AppLocale.icon.getString(context),
                  textAlign: TextAlign.center,
                ),
              )),
              DataColumn(
                label: Text(
                  AppLocale.name.getString(context),
                  textAlign: TextAlign.center,
                ),
                onSort: (columnIndex, _) {
                  setState(
                    () {
                      _currentSortColumn = columnIndex;
                      if (_isAscending == true) {
                        _isAscending = false;
                        // sort the name in Ascending, order by A to Z
                        widget.data.sort(
                          (a, b) => a.name.compareTo(b.name),
                        );
                      } else {
                        _isAscending = true;
                        // sort the name in Ascending, order by A to Z
                        widget.data.sort(
                          (a, b) => b.name.compareTo(a.name),
                        );
                      }
                    },
                  );
                },
              ),
              DataColumn(
                label: Text(
                  AppLocale.date.getString(context),
                  textAlign: TextAlign.center,
                ),
                numeric: true,
                onSort: (columnIndex, _) {
                  setState(
                    () {
                      _currentSortColumn = columnIndex;
                      if (_isAscending == true) {
                        _isAscending = false;
                        // sort datetime
                        widget.data.sort(
                          (a, b) => DateTime.parse(a.time).compareTo(
                            DateTime.parse(b.time),
                          ),
                        );
                      } else {
                        _isAscending = true;
                        // sort datetime
                        widget.data.sort(
                          (a, b) => DateTime.parse(b.time).compareTo(
                            DateTime.parse(a.time),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              DataColumn(
                label: Text(
                  AppLocale.success.getString(context),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            rows: const []),
        Expanded(
          child: SizedBox(
            child: SingleChildScrollView(
              child: DataTable(
                columnSpacing: 22,
                dataRowMinHeight: 50,
                dataRowMaxHeight: 100,
                showCheckboxColumn: false,
                headingRowHeight: 0,
                columns: List.generate(
                  4,
                  (index) => const DataColumn(
                    label: Text(''),
                  ),
                ), // GENERATE EMPTY COLUMNS

                rows: List.generate(
                  filteredData.length,
                  (index) {
                    final Launch item = filteredData[index];
                    return DataRow(
                      onSelectChanged: (value) {
                        Modular.to.pushNamed('/information', arguments: item);
                      },
                      cells: [
                        DataCell(
                          SizedBox(
                            width: 50,
                            child: CachedNetworkImage(
                              imageUrl: filteredData[index].image['small']!,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 70,
                            child: Text(
                              item.name,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            DateFormat('dd/MM/yyyy').format(
                              DateTime.parse(item.time),
                            ),
                          ),
                        ),
                        if (item.success != null)
                          DataCell(
                            Text(
                              item.success! ? 'success' : 'fail',
                              style: TextStyle(
                                  color: item.success!
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          )
                        else
                          const DataCell(
                            Text('No data'),
                          )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
