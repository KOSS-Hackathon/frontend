import 'package:flutter/material.dart';
import 'package:menurecommend/screen/addQuestion_screen.dart';
import 'package:menurecommend/screen/recommend_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Image.asset('assets/result.png', height: 300),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Color(0xFFE5E7EB), width: 5),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecommendScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFF5B8DEF),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '만족',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddquestionScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF5A5F),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '불만족',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
