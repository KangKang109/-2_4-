library global;
/*

전역변수 CO2값 배열 저장

*/
import 'package:flutter/foundation.dart';

class Global {
  // CO2 값을 저장하는 배열 (365일치)
  static List<ValueNotifier<double>> totalCO2 = 
      List.generate(365, (_) => ValueNotifier<double>(0.0));
}
