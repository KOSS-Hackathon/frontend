import 'package:flutter/material.dart';
import 'package:menurecommend/screen/question_screen.dart';
import 'package:menurecommend/widgets/custom_scaffold.dart';

import '../widgets/arc_text.dart';

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
              height: 200,
            ),

           ArcText(
               text: 'Yarrnator',
               radius: 160,
               style: TextStyle(
                 fontFamily: 'Rakkas',
                 fontSize: 78,
                 foreground: Paint()
                   ..shader = LinearGradient(
                     colors: [
                       Color(0xFFFF9A56),
                       Color(0xFFFF6B35),
                     ],
                     begin: Alignment.topCenter,
                     end: Alignment.bottomCenter,
                   ).createShader(Rect.fromLTWH(-400, -400, 800, 800)),
                 shadows: [
                   Shadow(
                     offset: Offset(4, 4),
                     blurRadius: 0,
                     color: Color(0xFF6A1BB1),
                   ),
                 ],
               )
           ),

            Transform.translate(
              offset: Offset(0, -50),
              child: Image.asset(
                'assets/question.png',
                height: 300,
              ),
            ),

            Transform.translate(
              offset: Offset(0, -50),
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.28),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: const Text(
                    '머릿속 바로 그 음식 내가 맞춰볼게!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Baloo 2',
                      fontSize: 14,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
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