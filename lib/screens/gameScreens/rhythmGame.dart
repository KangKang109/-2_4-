import 'package:flutter/material.dart';

class RhythmGameWidget extends StatefulWidget {
  const RhythmGameWidget({Key? key}) : super(key: key);

  @override
  State<RhythmGameWidget> createState() => _RhythmGameWidgetState();
}

class _RhythmGameWidgetState extends State<RhythmGameWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey[200],
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
            '리듬 게임',
            style: TextStyle(
              fontFamily: 'Inter Tight',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black, // 제목 텍스트 색상
            ),
          ),
        ),// 기본 배경색 설정
        body: SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/gameImages/rhythmGame.jpg',width: 300,height: 200,)
                ),
                Text(
                  '음악에 맞추어 리듬게임을 즐겨보세요 !\n전력을 아낀만큼 추가시간이 늘어납니다 !',
                  style: TextStyle(
                    fontFamily: 'Inter', // Google Fonts 설치 필요
                    fontSize: 16,
                    letterSpacing: 0.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF68B4FF), // 버튼 색상
                    foregroundColor: Colors.black, // 텍스트 색상
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Game Start',
                    style: TextStyle(
                      fontFamily: 'Inter Tight', // Google Fonts 설치 필요
                      fontSize: 16,
                      letterSpacing: 0.0,
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
}
