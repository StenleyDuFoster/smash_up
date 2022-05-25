import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dls_dto.dart';

class FractionFilterWidget extends StatefulWidget {
  late List<DlsDto> dls;
  late Function selectedDlsCallBack;

  FractionFilterWidget(List<DlsDto> dls, Function selectedDlsCallBack) {
    this.dls = removeDublicate(dls);
    this.selectedDlsCallBack = selectedDlsCallBack;
  }

  @override
  State createState() => _FractionFilterState();

  List<DlsDto> removeDublicate(List<DlsDto> data) {
    List<String> values = [];
    List<DlsDto> resultLis = [];

    data.forEach((element) {
      if (!values.contains(element.dlsName)) {
        resultLis.add(element);
        values.add(element.dlsName);
      } else {
        DlsDto currentData = resultLis.last;
        if (!currentData.isSelected && element.isSelected) {
          currentData.isSelected = true;
        }
      }
    });

    return resultLis;
  }
}

class _FractionFilterState extends State<FractionFilterWidget> {
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

  List<DlsDto> removeUnSelected(List<DlsDto> data) {
    List<DlsDto> result = [];
    data.forEach((element) {
      if (element.isSelected) {
        result.add(element);
      }
    });
    return result;
  }
}
