import 'package:flutter/material.dart';
import 'package:menurecommend/screen/question_screen.dart';
import 'package:menurecommend/widgets/custom_scaffold.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),

            const Text(
              'Yarrrnator',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF9A56),
              ),
            ),

            const SizedBox(height: 24),

            Image.asset(
              'assets/question.png',
              height: 220,
            ),

            const SizedBox(height: 12),

            Container(
              width: 300,
              decoration: BoxDecoration(
                color: Color(0xFFB04CB6).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Text(
                '질문 몇 개로\n오늘의 메뉴를 정해드립니다',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF000000),
                ),
              ),
            ),

            SizedBox(
              height: 50,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFF9A56),
                        Color(0xFFFF6B35),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(26)
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '시작',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
