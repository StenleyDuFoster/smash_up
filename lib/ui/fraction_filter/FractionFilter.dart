import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smash_up/domain/entity/set_enum.dart';

import '../../domain/entity/fraction_entity.dart';

class FractionFilterDialog extends AlertDialog {
  List<FractionEntity> fraction;
  List<FractionEntity> selectedFraction;
  Function selectedDlsCallBack;
  Widget title;

  FractionFilterDialog(
      {required this.fraction,
      required this.selectedFraction,
      required this.selectedDlsCallBack,
      required this.title})
      : super(
            content: _FractionFilterWidget(
                fraction.map((e) {
                  return _DlsDto(
                      dlsName: e.setName,
                      dlsType: e.set,
                      isSelected: selectedFraction.contains(e));
                }).toList(),
                selectedDlsCallBack),
            title: title);
}

class _FractionFilterWidget extends StatefulWidget {
  late List<_DlsDto> dls;
  late Function selectedDlsCallBack;

  _FractionFilterWidget(List<_DlsDto> dls, Function selectedDlsCallBack) {
    this.dls = removeDublicate(dls);
    this.selectedDlsCallBack = selectedDlsCallBack;
  }

  @override
  State createState() => _FractionFilterState();

  List<_DlsDto> removeDublicate(List<_DlsDto> data) {
    List<String> values = [];
    List<_DlsDto> resultLis = [];

    data.forEach((element) {
      if (!values.contains(element.dlsName)) {
        resultLis.add(element);
        values.add(element.dlsName);
      }
    });

    return resultLis;
  }
}

class _FractionFilterState extends State<_FractionFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    child: Text(widget.dls[index].dlsName),
                    color: widget.dls[index].isSelected
                        ? Colors.blue
                        : Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      widget.dls[index].isSelected =
                          !widget.dls[index].isSelected;
                    });
                  },
                );
              },
              itemCount: widget.dls.length,
            ),
          ),
          SizedBox(width: 20, height: 20),
          ElevatedButton(
              onPressed: () {
                widget.selectedDlsCallBack.call(removeUnSelected(widget.dls)
                    .map((e) => e.dlsType)
                    .toList());
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)?.apply ?? ""))
        ],
      ),
    );
  }

  List<_DlsDto> removeUnSelected(List<_DlsDto> data) {
    List<_DlsDto> result = [];
    data.forEach((element) {
      if (element.isSelected) {
        result.add(element);
      }
    });
    return result;
  }
}

class _DlsDto {
  String dlsName;
  SetEnum dlsType;
  bool isSelected;

  _DlsDto(
      {required this.dlsName, required this.dlsType, required this.isSelected});
}
