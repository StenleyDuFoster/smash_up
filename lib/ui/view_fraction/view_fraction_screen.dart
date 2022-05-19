import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smash_up/core/base_screen.dart';
import 'package:smash_up/domain/entity/fraction_entity.dart';

import '../../domain/entity/set_enum.dart';
import '../fraction_filter/FractionFilter.dart';

class ViewFractionScreen extends BaseScreen {
  ViewFractionScreen() : super(_ViewFractionScreen());
}

class _ViewFractionScreen extends BaseState<ViewFractionScreen> {
  List<FractionEntity> listData = List.empty();
  List<FractionEntity> allFraction = List.empty();
  List<SetEnum> filter = List.empty();

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
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Expanded(
            child: Text(AppLocalizations.of(context)?.watch_fraction ?? ""),
          ),
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
                          });
                        },
                      );
                    });
              },
              icon: Icon(Icons.sort),
              label: Text(AppLocalizations.of(context)?.filter_by_dlc ?? ""))
        ],
      )),
      body: Column(
        children: [Expanded(child: _buildList()), _buildAddButton()],
      ),
    );
  }

  Widget _buildList() {
    return GridView.builder(
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          child: Card(
            child: Container(
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

  Widget _buildAddButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        style: ButtonStyle(),
        child: Padding(
          child: Text(AppLocalizations.of(context)?.add_fraction ?? ""),
          padding: EdgeInsets.all(20),
        ),
        onPressed: () => {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)?.in_develop ?? ""),
          ))
        },
      ),
    );
  }
}
