import 'package:flutter/cupertino.dart';

class BaseScreen extends StatefulWidget {

  late BaseState _state;

  BaseScreen(BaseState state) {
    _state = state;
  }

  @override
  State<StatefulWidget> createState() => _state;

}

abstract class BaseState<T extends BaseScreen> extends State<T> {



}