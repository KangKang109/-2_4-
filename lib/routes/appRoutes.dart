import 'package:get/get.dart';
import '../screens/LoginScreen.dart';
import '../screens/MainScreen.dart';
import '../screens/RewardScreen.dart';
import '../screens/SmartThingsDataScreen.dart';
import '../screens/gameScreens/whichGame.dart';
import '../screens/homeScreen.dart';
import '../screens/pointScreen.dart';
import '../screens/gameScreens/runGame.dart';
import '../screens/gameScreens/bingoGame.dart';
import '../screens/gameScreens/matchingGame.dart';
import '../screens/gameScreens/puzzleGame.dart';
import '../screens/gameScreens/rhythmGame.dart';
import '../Co2Analysis.dart';
import '../DataAnalysis.dart';

class AppRoutes{
  static final routes = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/main', page: () => MainScreen()),
    GetPage(name: '/reward', page: () => RewardScreen()),
    GetPage(name: '/data', page: () => SmartThingsDataScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/point', page: ()=>PointWidget()),
    GetPage(name: '/runGame', page: ()=> RunGameWidget()),
    GetPage(name: '/bingoGame', page: ()=>BingoGameWidget()),
    GetPage(name: '/matchingGame', page: ()=> MatchingGameWidget()),
    GetPage(name: '/puzzleGame', page: ()=> PuzzleGameWidget()),
    GetPage(name: '/rhythmGame', page: ()=> RhythmGameWidget()),
    GetPage(name: '/whichGame', page: ()=>WhichGameWidget()),
    GetPage(name: '/co2', page: ()=>Co2Analysis()),
  ];
}