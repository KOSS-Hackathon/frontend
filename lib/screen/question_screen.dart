import 'package:flutter/material.dart';
import 'package:menurecommend/screen/result_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String? category;
  String? taste;
  String? method;
  String? temp;

  int step = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'key': 'category',
      'title': '어떤 나라 음식이 좋아?',
      'options': [
        {'label': '한식', 'value': 'korean'},
        {'label': '일식', 'value': 'japanese'},
        {'label': '중식', 'value': 'chinese'},
        {'label': '양식', 'value': 'western'},
        {'label': '기타', 'value': 'etc'},
      ],
    },
    {
      'key': 'taste',
      'title': '어떤 맛을 원해?',
      'options': [
        {'label': '매운맛', 'value': 'spicy'},
        {'label': '느끼한 맛', 'value': 'greasy'},
        {'label': '담백한 맛', 'value': 'plain'},
        {'label': '기타', 'value': 'etc'},
      ],
    },
    {
      'key': 'method',
      'title': '조리 방식은?',
      'options': [
        {'label': '튀김', 'value': 'fried'},
        {'label': '구이', 'value': 'grilled'},
        {'label': '국물', 'value': 'soup'},
        {'label': '기타', 'value': 'etc'},
      ],
    },
    {
      'key': 'temp',
      'title': '온도는?',
      'options': [
        {'label': '뜨거운 음식', 'value': 'hot'},
        {'label': '따뜻한 음식', 'value': 'warm'},
        {'label': '차가운 음식', 'value': 'cold'},
      ],
    },
  ];

  void selectOption(String value) {
    setState(() {
      final key = questions[step]['key'];

      if (key == 'category') category = value;
      if (key == 'taste') taste = value;
      if (key == 'method') method = value;
      if (key == 'temp') temp = value;

      if (step < questions.length - 1) {
        step++;
      } else {
        // 🔽 나중에 여기서 API 호출
        debugPrint({
          'category': category,
          'taste': taste,
          'method': method,
          'temp': temp,
        }.toString());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = questions[step];

    return Scaffold(
      appBar: AppBar(
        title: Text('질문 ${step + 1}/${questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              current['title'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            ...current['options'].map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: Color(0xFF5B8DEF),
                    foregroundColor: Color(0xFFFFFFFF)
                  ),
                  onPressed: () => selectOption(option['value']),
                  child: Text(option['label']),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}