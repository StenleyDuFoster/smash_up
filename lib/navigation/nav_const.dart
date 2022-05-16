import 'package:flutter/material.dart';
import 'package:smash_up/ui/create_game/create_game_screen.dart';
import 'package:smash_up/ui/created_fraction/created_fraction_screen.dart';
import 'package:smash_up/ui/start_screen/start_screen.dart';
import 'package:smash_up/ui/view_fraction/view_fraction_screen.dart';

enum Screen {
  Start, ViewFraction, CreatedFraction, CreateGame
}

extension ScreenExt on Screen {
  Widget get screen {
    switch (this) {
      case Screen.Start:
        return StartScreen();
      case Screen.ViewFraction:
        return ViewFractionScreen();
      case Screen.CreatedFraction:
        return CreatedFractionScreen();
      case Screen.CreateGame:
        return CreateGameScreen();
    }
  }
  String get name {
    switch (this) {
      case Screen.Start:
        return "Start";
      case Screen.ViewFraction:
        return "ViewFraction";
      case Screen.CreatedFraction:
        return "CreatedFraction";
      case Screen.CreateGame:
        return "CreateGame";
    }
  }
}