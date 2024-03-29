import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

class ColorHelper {

  final List<Color> _colors = [
    Colors.amber,
    Colors.amberAccent,
    Colors.black26,
    Colors.black12,
    Colors.blueAccent,
    Colors.blue,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.grey,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.lime,
    Colors.limeAccent,
    Colors.orange,
    Colors.orangeAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.red,
    Colors.redAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.white70
  ];

  List<Color> generateRandomList(int size, List<Color> startList) {
    List<Color> resultList = [];
    LinkedList<_ColorEntry> colorCopy = LinkedList();
    colorCopy.addAll(_colors.map((e) {
      return _ColorEntry(e);
    }).toList());

    startList.forEach((element) {
      try {
        colorCopy.remove(colorCopy.firstWhere((element) =>
            startList.contains(element.color)));
      } catch (e) {

      }
    });

    for (int i = 0; i < size; i++) {
      if (colorCopy.isNotEmpty) {
          _ColorEntry randomColor = colorCopy.elementAt(
              Random.secure().nextInt(colorCopy.length));
          resultList.add(randomColor.color);
          colorCopy.remove(randomColor);
      } else {
        resultList.add(Color.fromARGB(Random.secure().nextInt(255), Random.secure().nextInt(255), Random.secure().nextInt(255), Random.secure().nextInt(255)));
      }
    }

    return resultList;
  }

}

class _ColorEntry extends LinkedListEntry<_ColorEntry> {
  final Color color;
  _ColorEntry(this.color);

  @override
  String toString() {
    return '$color';
  }
}
