import "package:flutter/widgets.dart";
import 'package:mtg_life/player_screens/player_screens.dart';
class AppConfiguration extends ChangeNotifier {
  PlayerScreens playerScreen;
  Map<int, String> playerTheme;

  AppConfiguration({
    this.playerScreen,
    this.playerTheme
  }): assert(playerScreen != null),
      assert(playerTheme != null);

  void setPlayerScreen(PlayerScreens p) {
    this.playerScreen = p;
    notifyListeners();
  }

  static AppConfiguration FromStorage() {
    // TODO: Implement storage
    return AppConfiguration.FromDefaults();
  }

  static AppConfiguration FromDefaults() {
    return AppConfiguration(
      playerScreen: PlayerScreens.TWO_PLAYER,
      playerTheme: <int, String> {
        1: "izzet",
        2: "azorius",
        3: "golgari",
        4: "dimir"
      }
    );
  }
}