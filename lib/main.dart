
import 'package:flutter/material.dart';
import 'package:mtg_life/models/app_configuration.dart';
import 'package:mtg_life/player_screens/four_player.dart';
import 'package:mtg_life/player_screens/player_screens.dart';
import 'package:mtg_life/player_screens/three_player.dart';
import 'package:mtg_life/player_screens/two_player.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Lifecounter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.green,
      ),
      home: ChangeNotifierProvider<AppConfiguration>(
        builder: (_ctx) => AppConfiguration.FromDefaults(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin
{

  AnimationController playerScreenTransitionController;

  @override
  void initState() {
    playerScreenTransitionController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    playerScreenTransitionController.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF38322A),
      body: Consumer<AppConfiguration>(
              builder: (ctx, config, w) {
                switch(config.playerScreen) {
                  case PlayerScreens.FOUR_PLAYER:
                    return FourPlayerScreen(playerScreenTransitionController);
                  case PlayerScreens.THREE_PLAYER:
                    return ThreePlayerScreen(playerScreenTransitionController);
                  case PlayerScreens.TWO_PLAYER:
                  default:
                    return TwoPlayerScreen(playerScreenTransitionController);
                }
              },
          ),
    );
  }
}
