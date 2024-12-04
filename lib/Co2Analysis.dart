import 'package:flutter/material.dart';
import 'global.dart' as global;

class Co2Analysis extends StatefulWidget {
  const Co2Analysis({super.key});

  @override
  _Co2AnalysisState createState() => _Co2AnalysisState();
}

class _Co2AnalysisState extends State<Co2Analysis> {
  // 어제 대비 CO2 절약 비율 계산
  double _calculateSavingPercentage() {
    double yesterdayValue = 0.0;
    double todayValue = 0.0;

    if (global.Global.currentIndex - 1 >= 0) {
      yesterdayValue = global.Global.totalCO2[global.Global.currentIndex - 2].value;
      todayValue = global.Global.totalCO2[global.Global.currentIndex - 1].value;
    } else {
      yesterdayValue = 1;
      todayValue = 3;
    }

    print("index-1 값 : ${yesterdayValue}");
    print("index 값 : ${todayValue}");
    if (yesterdayValue > 0) {
      double savingPercentage = ((yesterdayValue - todayValue) / yesterdayValue) * 100;

      // 게임 티켓 추가 로직
      if (savingPercentage >= 5 && savingPercentage < 10) {
        global.Global.gameTickets += 5;
      } else if (savingPercentage >= 10 && savingPercentage < 15) {
        global.Global.gameTickets += 10;
      } else if (savingPercentage >= 15) {
        global.Global.gameTickets += 15;
      }

      return savingPercentage;
    }

    return -1; // 계산 불가 시 반환
  }

  // index[0]부터 index[30]까지의 CO2 총합 계산
  double _calculateCO2Sum() {
    int endIndex = (global.Global.currentIndex + 30) < global.Global.totalCO2.length
        ? (global.Global.currentIndex + 30)
        : global.Global.totalCO2.length - 1;

    return global.Global.totalCO2
        .sublist(0, endIndex + 1)
        .fold(0.0, (sum, co2Entry) => sum + co2Entry.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내가 아낀 탄소 배출량 보기')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 오늘의 CO2 값을 표시
            ValueListenableBuilder<double>(
              valueListenable: global.Global.totalCO2[global.Global.currentIndex],
              builder: (context, totalCO2, child) {
                return Text(
                  '오늘의 이산화 탄소 배출량: ${totalCO2.toStringAsFixed(2)} kg',
                  style: const TextStyle(fontSize: 18),
                );
              },
            ),
            const SizedBox(height: 16),
            // 어제 대비 절약 비율 표시
            Text(
              '어제보다 ${_calculateSavingPercentage().toStringAsFixed(2)}% 만큼 절약하였습니다!',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            // index[0]부터 index[30]까지의 CO2 총합 표시
            Text(
              '이번달 총 CO2 배출량: ${_calculateCO2Sum().toStringAsFixed(2)} kg',
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
            const SizedBox(height: 16),
            // 게임 티켓 수 표시
            Text(
              '현재 보유 게임 티켓 수: ${global.Global.gameTickets}',
              style: const TextStyle(fontSize: 18, color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
