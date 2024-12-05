import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/appRoutes.dart';

class WhichGameWidget extends StatefulWidget {
  const WhichGameWidget({Key? key}) : super(key: key);

  @override
  State<WhichGameWidget> createState() => _WhichGameWidgetState();
}

class _WhichGameWidgetState extends State<WhichGameWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white, // AppBar 배경색
          elevation: 0, // AppBar 그림자 제거
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black), // 뒤로가기 버튼
            onPressed: () {
              Navigator.of(context).pop(); // 이전 화면으로 이동
            },
          ),
          centerTitle: true,
        ),// FlutterFlowTheme의 primaryBackground 대체
        body: SafeArea(
          top: true,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // FlutterFlowTheme의 secondaryBackground 대체
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '원하는 게임을 골라주세요!',
                          style: TextStyle(
                            fontFamily: 'Inter Tight',
                            fontSize: 20,
                            color: Colors.black, // FlutterFlowTheme의 primaryText 대체
                            letterSpacing: 0.0,
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildGameButton('퍼즐 게임',_navigateToPuzzleGame),
                        const SizedBox(height: 30),
                        _buildGameButton('리듬 게임',_navigateToRhythmGame),
                        const SizedBox(height: 30),
                        _buildGameButton('러너 게임',_navigateToRunnerGame),
                        const SizedBox(height: 30),
                        _buildGameButton('매칭 게임',_navigateToMatchingGame),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(300, 100),
        backgroundColor: const Color(0xFF68B4FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter Tight',
          fontSize: 16,
          color: Colors.black, // FlutterFlowTheme의 primaryText 대체
          letterSpacing: 0.0,
        ),
      ),
    );
  }
  void _navigateToPuzzleGame() {
    print('퍼즐 게임 화면으로 이동합니다.');
    Get.toNamed('/puzzleGame');
  }

  void _navigateToRhythmGame() {
    print('리듬 게임 화면으로 이동합니다.');
    Get.toNamed('/rhythmGame');
  }

  void _navigateToRunnerGame() {
    print('러너 게임 화면으로 이동합니다.');
    Get.toNamed('/runGame');
  }

  void _navigateToMatchingGame() {
    print('매칭 게임 화면으로 이동합니다.');
    Get.toNamed('/matchingGame');
  }
}
