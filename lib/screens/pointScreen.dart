import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/appRoutes.dart';

class PointWidget extends StatefulWidget {
  const PointWidget({Key? key}) : super(key: key);

  @override
  State<PointWidget> createState() => _PointWidgetState();
}

class _PointWidgetState extends State<PointWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
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
          title: Text(
            '포인트',
            style: TextStyle(
              fontFamily: 'Inter Tight',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black, // 제목 텍스트 색상
            ),
          ),
        ),// Primary background color
        body: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildCard(
                    context,
                    title: '포인트 받기',
                    buttons: [
                      _buildButton(context, '게임하고 포인트 받기', () {
                        Get.toNamed('/whichGame');
                        print('Button pressed: 게임하고 포인트 받기');
                      }),
                      _buildButton(context, '빙고하고 포인트 받기', () {
                        Get.toNamed('/bingoGame');
                        print('Button pressed: 빙고하고 포인트 받기');
                      }),
                    ],
                  ),
                  SizedBox(height: 24),
                  _buildCard(
                    context,
                    title: '포인트 사용하기',
                    buttons: [
                      _buildButton(context, '포인트 순위 보기', () {
                        print('Button pressed: 포인트 순위 보기');
                      }),
                      _buildButton(context, '포인트 교환소', () {
                        print('Button pressed: 포인트 교환소');
                      }),
                    ],
                  ),
                  SizedBox(height: 24),
                  _buildCard(
                    context,
                    title: '내 포인트',
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '내 포인트',
                            style: TextStyle(
                              fontFamily: 'Inter Tight',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '1,234 P',
                            style: TextStyle(
                              fontFamily: 'Inter Tight',
                              fontSize: 16,
                              color: Color(0xFF68B4FF),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        '2024년 1월 획득 포인트: 234 P',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '2024년 누적 포인트: 1,234 P',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, List<Widget>? buttons, List<Widget>? children}) {
    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: Colors.grey[100], // Secondary background color
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter Tight',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          if (buttons != null) ...buttons.map((btn) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: btn,
          )),
          if (children != null) ...children,
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF68B4FF), // Button color
        minimumSize: const Size(300, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter Tight',
          fontSize: 14,
          color: Colors.white, // Text color
        ),
      ),
    );
  }
}
