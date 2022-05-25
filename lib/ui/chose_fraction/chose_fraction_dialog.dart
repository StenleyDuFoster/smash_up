import 'package:flutter/material.dart';

import '../../domain/entity/fraction_entity.dart';
import 'chose_fraction_widget.dart';

class ChoseFractionDialog extends AlertDialog {
  @override
  Widget title;
  Function selectedFractionCallback;
  List<FractionEntity> oldSelected;

  ChoseFractionDialog(
      {Key? key,
      required this.selectedFractionCallback,
      required this.title,
      required this.oldSelected})
      : super(
            key: key,
            content: SelectFractionWidget(
              selectedFractionCallback: selectedFractionCallback,
              oldSelected: oldSelected,
            ),
            title: title);
}
