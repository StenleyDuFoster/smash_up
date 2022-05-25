import 'package:flutter/material.dart';

import '../../domain/entity/fraction_entity.dart';
import 'dls_dto.dart';
import 'fraction_filter_widget.dart';

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
            content: FractionFilterWidget(
                fraction.map((e) {
                  return DlsDto(
                      dlsName: e.setName,
                      dlsType: e.set,
                      isSelected: selectedFraction.contains(e));
                }).toList(),
                selectedDlsCallBack),
            title: title);
}

