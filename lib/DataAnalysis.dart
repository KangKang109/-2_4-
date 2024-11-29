import 'package:flutter/material.dart';
import 'RewardScreen.dart'; 
import 'SmartThingsDataScreen.dart'; // 새 화면 위젯을 임포트합니다.
import 'global.dart' as global; 

class DataAnalysisPage extends StatelessWidget {
  final int index; // 전달받은 index 값

  DataAnalysisPage({required this.index});

  @override
  Widget build(BuildContext context) {
    // 현재 이산화탄소 배출량 가져오기
    double currentCO2Emission = global.Global.totalCO2[index].value;
    String analysisResult = 
        currentCO2Emission <= 5.4 ? '현재 소비 적절' : '현재 소비 과다';

    return Scaffold(
      appBar: AppBar(title: const Text('데이터 분석 결과')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '1인가구의 월 평균 이산화탄소 배출량은 162kg입니다. (일 : 5.2kg)',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                analysisResult,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
