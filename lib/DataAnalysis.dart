import 'package:flutter/material.dart';
import 'global.dart' as global;

class DataAnalysisPage extends StatelessWidget {
  final int index; // 전달받은 index 값

  DataAnalysisPage({required this.index});

  @override
  Widget build(BuildContext context) {
    // 현재 이산화탄소 배출량 가져오기
    double currentCO2Emission = global.Global.totalCO2[index].value;
    double yesterdayCO2Emission =
        index > 0 ? global.Global.totalCO2[index - 1].value : currentCO2Emission;

    // 어제 대비 아낀 비율 계산
    double savedPercentage = 0.0;
    if (yesterdayCO2Emission > 0) {
      savedPercentage =
          ((yesterdayCO2Emission - currentCO2Emission) / yesterdayCO2Emission) * 100;
    }

    // 아낀 비율에 따라 게임 티켓 추가
    if (savedPercentage >= 5 && savedPercentage < 10) {
      global.Global.gameTickets += 5;
    } else if (savedPercentage >= 10 && savedPercentage < 15) {
      global.Global.gameTickets += 10;
    } else if (savedPercentage >= 15) {
      global.Global.gameTickets += 15;
    }

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    analysisResult,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '어제보다 아낀 비율: ${savedPercentage.toStringAsFixed(2)}%',
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '현재 게임 티켓 수: ${global.Global.gameTickets}',
                    style: const TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
