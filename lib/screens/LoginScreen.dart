import 'package:flutter/material.dart';
import 'MainScreen.dart';  // MainScreen을 임포트합니다.
import 'package:get/get.dart';
import '../routes/appRoutes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoggedIn = false;  // 로그인 상태를 관리하는 변수

  void _login() {
    // 관리자 계정(root, 1234) 처리
    if (_usernameController.text == 'root' && _passwordController.text == '1234') {
      setState(() {
        _isLoggedIn = true;  // 로그인 상태를 true로 변경
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('로그인 성공')));
      // 로그인 성공 시 MainScreen으로 이동
      Get.toNamed('/home');

    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('로그인 실패')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: '아이디'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('로그인'),
            ),
            if (_isLoggedIn)  // 로그인 상태일 때만 "환영합니다" 버튼 표시
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('환영합니다!')));
                },
                child: const Text('환영합니다'),
              ),
          ],
        ),
      ),
    );
  }
}
