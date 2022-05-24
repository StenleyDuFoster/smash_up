import 'package:SmashUp/domain/entity/fraction_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui' as ui;

import '../../util/app_locale.dart';

class FractionWidget extends StatefulWidget {
  FractionEntity item;
  bool? isSelected;
  Function? clickListener;
  bool Function()? tapNow;

  FractionWidget(
      {required this.item, this.clickListener, this.isSelected, this.tapNow});

  @override
  State<StatefulWidget> createState() => _FractionState();
}

class _FractionState extends State<FractionWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: InkWell(
          child: Container(
            color: widget.isSelected == true ? Colors.blue : Colors.white,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    widget.item.getAssetImage(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      Text(
                        widget.item.getLocalizedName(AppLocale.instance.current),
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.item.getLocalizedName(AppLocale.instance.current),
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onHover: (hover) {
            // if (!hover) {
            //   return;
            // }
            // bool tapNow;
            // if (widget.tapNow == null) {
            //   return;
            // }
            // tapNow = widget.tapNow!();
            // if (!tapNow) {
            //   return;
            // }
            // bool? isSelected = widget.isSelected;
            // if (isSelected != null) {
            //   setState(() {
            //     widget.isSelected = !isSelected;
            //   });
            // }
            // widget.clickListener?.call();
          },
          onTap: () {
            bool? isSelected = widget.isSelected;
            if (isSelected != null) {
              setState(() {
                widget.isSelected = !isSelected;
              });
            }
            widget.clickListener?.call();
          },
        ),
      ),
    );
  }
}
