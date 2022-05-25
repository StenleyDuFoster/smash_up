import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/base_screen.dart';
import '../../data/local/fraction_singletone.dart';
import '../../domain/entity/fraction_entity.dart';
import '../../domain/entity/set_enum.dart';
import '../fraction_filter/FractionFilter.dart';
import '../shared/fraction_item.dart';

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
    List<FractionEntity> parsedList = await Fraction.instance.getData();
    setState(() {
      listData = parsedList;
      allFraction = parsedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Fraction.instance.getData(),
      builder: (context, snapshot) {
        if (snapshot.data == null && allFraction.isEmpty) {
          return Container(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else {
          listData = snapshot.data as List<FractionEntity>;
          allFraction = snapshot.data as List<FractionEntity>;

          return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    BackButton(),
                    Expanded(
                      child: Text(
                          AppLocalizations.of(context)?.watch_fraction ?? ""),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return FractionFilterDialog(
                                  title: Text(AppLocalizations.of(context)
                                          ?.select_dls ??
                                      ""),
                                  fraction: allFraction,
                                  selectedFraction: listData,
                                  selectedDlsCallBack: (List<SetEnum> filters) {
                                    setState(() {
                                      listData = allFraction
                                          .where((element) =>
                                              filters.contains(element.set))
                                          .toList();
                                    });
                                  },
                                );
                              });
                        },
                        icon: Icon(Icons.sort),
                        label: Text(
                            AppLocalizations.of(context)?.filter_by_dlc ?? ""))
                  ],
                )),
            body: Column(
              children: [Expanded(child: _buildList()), _buildAddButton()],
            ),
          );
        }
      },
    );
  }

  Widget _buildList() {
    double size = MediaQuery.of(context).size.width / 105;
    return GridView.builder(
      itemBuilder: (BuildContext context, int index) {
        return FractionWidget(item: listData[index]);
      },
      itemCount: listData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: size.toInt(),
        crossAxisSpacing: size,
        mainAxisSpacing: size,
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
