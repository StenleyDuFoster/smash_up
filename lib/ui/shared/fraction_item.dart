import 'package:SmashUp/domain/entity/fraction_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FractionWidget extends StatefulWidget {

  FractionEntity item;
  bool? isSelected;
  Function? clickListener;

  FractionWidget({required this.item, this.clickListener, this.isSelected});

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
            color: widget.isSelected == true
                ? Colors.blue
                : Colors.white,
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
                        widget.item.name,
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.item.name,
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