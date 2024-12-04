import 'package:flutter/material.dart';
import 'MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',  // 앱 제목
      theme: ThemeData(primarySwatch: Colors.blue),  // 앱 테마 설정
      home: const MainScreen(),  // 홈 화면을 LoginScreen으로 설정
    );
  }
}
