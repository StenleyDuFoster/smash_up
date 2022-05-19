import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entity/fraction_entity.dart';
import '../../domain/entity/set_enum.dart';
import '../fraction_filter/FractionFilter.dart';

class ChoseFractionDialog extends AlertDialog {
  Widget title;
  Function selectedFractionCallback;

  ChoseFractionDialog(
      {required this.selectedFractionCallback, required this.title})
      : super(
            content: _SelectFractionWidget(
                selectedFractionCallback: selectedFractionCallback),
            title: title);
}

class _SelectFractionWidget extends StatefulWidget {
  Function selectedFractionCallback;

  _SelectFractionWidget({required this.selectedFractionCallback});

  @override
  State<StatefulWidget> createState() => _SelectFractionState();
}

class _SelectFractionState extends State<_SelectFractionWidget> {
  List<FractionEntity> listData = [];
  List<FractionEntity> selectedData = [];
  List<FractionEntity> allFraction = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future _getData() async {
    WidgetsFlutterBinding.ensureInitialized();
    String data = await rootBundle.loadString('assets/all_fraction.json');
    List<FractionEntity> parsedList = List<FractionEntity>.from(
        await json.decode(data).map((model) => FractionEntity.fromJson(model)));
    this.setState(() {
      listData = parsedList;
      allFraction = parsedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width / 1.5,
      child: Column(
        children: [
          ElevatedButton.icon(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return FractionFilterDialog(
                        title: Text(
                            AppLocalizations.of(context)?.select_dls ?? ""),
                        fraction: allFraction,
                        selectedFraction: listData,
                        selectedDlsCallBack: (List<SetEnum> filters) {
                          setState(() {
                            listData = allFraction
                                .where(
                                    (element) => filters.contains(element.set))
                                .toList();
                            selectedData = selectedData
                                .where(
                                    (element) => filters.contains(element.set))
                                .toList();
                          });
                        },
                      );
                    });
              },
              icon: Icon(Icons.sort),
              label: Text(AppLocalizations.of(context)?.filter_by_dlc ?? "")),
          Expanded(
            child: Padding(
              child: _buildList(),
              padding: EdgeInsets.all(10),
            ),
          ),
          TextButton(
              onPressed: () {
                widget.selectedFractionCallback(selectedData);
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)?.apply ?? ""))
        ],
      ),
    );
  }

  Widget _buildList() {
    return GridView.builder(
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          child: Card(
            child: InkWell(
              child: Container(
                color: selectedData.contains(listData[index])
                    ? Colors.blue
                    : Colors.white,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        listData[index].getAssetImage(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        children: [
                          Text(
                            listData[index].name,
                            style: TextStyle(
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            listData[index].name,
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                if (selectedData.contains(listData[index])) {
                  selectedData.remove(listData[index]);
                } else {
                  selectedData.add(listData[index]);
                }
                setState(() {
                  selectedData = selectedData;
                });
              },
            ),
          ),
        );
      },
      itemCount: listData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (MediaQuery.of(context).size.width / 105).toInt(),
        crossAxisSpacing: MediaQuery.of(context).size.width / 105,
        mainAxisSpacing: MediaQuery.of(context).size.width / 105,
      ),
    );
  }
}
