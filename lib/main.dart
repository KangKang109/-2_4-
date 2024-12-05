import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';
import './routes/appRoutes.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
