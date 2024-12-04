import 'package:flutter/material.dart';
import 'Co2Analysis.dart'; 
import 'SmartThingsDataScreen.dart'; // 새 화면 위젯을 임포트합니다.
import 'global.dart' as global;

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
/*

메뉴
1. SmartThigs 데이터 가져오기
2. Reward
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SmartThingsDataScreen()),
                );
              },
              child: const Text('SmartThings 데이터 가져오기'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Co2Analysis()),
                );
              },
              child: const Text('내가 아낀 탄소 배출량 보기'),
            ),
          ],
        ),
      ),
    );
  }
}
