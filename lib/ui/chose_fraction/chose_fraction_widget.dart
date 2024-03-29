import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/local/fraction_local_db.dart';
import '../../data/local/fraction_singletone.dart';
import '../../domain/entity/fraction_entity.dart';
import '../../domain/entity/set_enum.dart';
import '../fraction_filter/fraction_filter.dart';
import '../shared/fraction_item.dart';

class SelectFractionWidget extends StatefulWidget {
  Function selectedFractionCallback;
  List<FractionEntity> oldSelected;

  SelectFractionWidget(
      {required this.selectedFractionCallback, required this.oldSelected});

  @override
  State<StatefulWidget> createState() =>
      _SelectFractionState(selectedData: oldSelected);
}

class _SelectFractionState extends State<SelectFractionWidget> {
  List<FractionEntity> listData = [];
  List<FractionEntity> selectedData;
  List<FractionEntity> allFraction = [];

  _SelectFractionState({required this.selectedData});

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future _getData() async {
    List<FractionEntity> parsedList = await Fraction.instance.getData();
    setState(() {
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
                        selectedFraction: selectedData,
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
              icon: const Icon(Icons.sort),
              label: Text(AppLocalizations.of(context)?.filter_by_dlc ?? "")),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: _buildList(),
            ),
          ),
          TextButton(
              onPressed: () {
                widget.selectedFractionCallback(selectedData);
                FractionLocalDb.instance().saveSelectedFraction(selectedData);
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)?.apply ?? ""))
        ],
      ),
    );
  }

  Widget _buildList() {
    bool tapNow = false;
    double size = MediaQuery.of(context).size.width / 105;
    return GridView.builder(
      itemBuilder: (BuildContext context, int index) {
        FractionEntity? findedFraction;
        try {
          findedFraction = selectedData.firstWhere((e) {
            return e.name == listData[index].name;
          });
        } catch (e) {}
        return FractionWidget(
          item: listData[index],
          isSelected: findedFraction != null,
          clickListener: () {
            FractionEntity? findedFraction;
            try {
              findedFraction = selectedData.firstWhere((e) {
                return e.name == listData[index].name;
              });
            } catch (e) {}
            if (findedFraction == null) {
              selectedData.add(listData[index]);
            } else {
              selectedData.remove(findedFraction);
            }
          },
          tapNow: () => tapNow,
        );
      },
      itemCount: listData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: size.toInt(),
        crossAxisSpacing: size,
        mainAxisSpacing: size,
      ),
    );
  }
}
