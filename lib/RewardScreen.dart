import 'package:flutter/material.dart';
import 'global.dart' as global;

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  _RewardScreenState createState() => _RewardScreenState();
}
/*
global.Global.totalCO2[currentIndex] 값 기반으로 리워드 작성 
*/
class _RewardScreenState extends State<RewardScreen> {
  int currentIndex = 0; // 현재 인덱스를 관리하는 변수
  double characterGrowth = 0.0;
  void _updateCO2Value(double newValue) {
    setState(() {
      if (currentIndex >= 0 && currentIndex < global.Global.totalCO2.length) {
        // 이전 값 저장
        final previousValue = global.Global.totalCO2[currentIndex].value;

        // 새 값을 업데이트
        global.Global.totalCO2[currentIndex].value = newValue;

        // CO2 감소량 계산
        final co2Difference = previousValue - newValue;
        characterGrowth += co2Difference;

        print("이전 CO2 값: $previousValue, 새로운 값: $newValue");
        print("CO2 차이: $co2Difference");
        print("누적 성장: $characterGrowth");

        // 다음 인덱스로 이동
        currentIndex = (currentIndex + 1) % global.Global.totalCO2.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캐릭터 성장')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 현재 CO2 값을 표시
            ValueListenableBuilder<double>(
              valueListenable: global.Global.totalCO2[currentIndex],
              builder: (context, totalCO2, child) {
                return Text(
                  '오늘의 이산화 탄소 배출량: ${totalCO2.toStringAsFixed(2)} kg',
                  style: const TextStyle(fontSize: 18),
                );
              },
            ),
            const SizedBox(height: 16),
            // 캐릭터 성장 표시
            Text(
              '캐릭터 성장: ${characterGrowth.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            // 성장하기 버튼
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 새 CO2 값을 감소시켜 업데이트
                  final currentValue = global.Global.totalCO2[currentIndex].value;
                  final newValue = (currentValue - 0.1).clamp(0.0, double.infinity);
                  _updateCO2Value(newValue);
                },
                child: const Text('성장하기'),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
