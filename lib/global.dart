library global;

/*

전역변수 CO2값 배열 저장

*/
import 'package:flutter/foundation.dart';

class Global {
  // CO2 값을 저장하는 배열 (365일치)
  static List<ValueNotifier<double>> totalCO2 = 
      List.generate(365, (_) => ValueNotifier<double>(0.0));

  // 배열의 현재 인덱스 (초기값 0)
  static int currentIndex = 1;

  // 게임 이용권 개수 (초기값 0)
  static int gameTickets = 0;
}
