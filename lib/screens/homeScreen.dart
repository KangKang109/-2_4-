import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/appRoutes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6), // 배경색 설정
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    '프로젝트 제목 머시기 머시기',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 30,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                _buildButtonContainer(
                  context,
                  'SmartThings 데이터 보기',
                      () => Get.toNamed('/data'),
                ),
                _buildButtonContainer(
                  context,
                  '내가 아낀 탄소 배출량 보기',
                      () => Get.toNamed('/co2'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                      child: _buildSmallButtonContainer(
                        context,
                        '포인트',
                            () => Get.toNamed('/point'),
                      ),
                    ),
                    _buildSmallButtonContainer(
                      context,
                      '경품 응모',
                          () => Get.toNamed('/reward'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonContainer(BuildContext context, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white, // Secondary Background
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF68B4FF), // Button Color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter Tight',
              fontSize: 18,
              color: Colors.black, // Primary Text Color
              letterSpacing: 0.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallButtonContainer(BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      width: 140,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white, // Secondary Background
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF68B4FF), // Button Color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter Tight',
            fontSize: 16,
            color: Colors.black, // Primary Text Color
            letterSpacing: 0.0,
          ),
        ),
      ),
    );
  }
}
