import 'package:flutter/material.dart';
import 'RewardScreen.dart';
import 'SmartThingsDataScreen.dart'; // 새 화면 위젯을 임포트합니다.
import 'package:get/get.dart';
import '../routes/appRoutes.dart';
import '../global.dart' as global;

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
                Get.toNamed('/data');
              },
              child: const Text('SmartThings 데이터 가져오기'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RewardScreen()),
                );
              },
              child: const Text('리워드 화면으로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}
