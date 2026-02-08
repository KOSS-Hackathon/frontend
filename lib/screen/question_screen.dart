import 'package:flutter/material.dart';
import 'package:menurecommend/screen/result_screen.dart';
import 'package:menurecommend/services/api_service.dart';
import 'package:menurecommend/widgets/custom_scaffold.dart';

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
  bool isLoading = false;

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

  void selectOption(String value) async {
    final key = questions[step]['key'];

    setState(() {
      if (key == 'category') category = value;
      if (key == 'taste') taste = value;
      if (key == 'method') method = value;
      if (key == 'temp') temp = value;
    });

    if (step < questions.length - 1) {
      setState(() {
        step++;
      });
    } else {
      setState(() {
        isLoading = true;
      });

      final result = await ApiService.getRecommendation(
        category: category!,
        taste: taste!,
        methods: method!,
        temp: temp!,
      );

      setState(() {
        isLoading = false;
      });

      if (result != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(menuData: result),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('추천을 가져오는데 실패했습니다. 다시 시도해주세요.')),
        );

        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = questions[step];

    return CustomScaffold(
      body: isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('메뉴를 추천하는 중...'),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '${step + 1}/${questions.length}',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),

            SizedBox(
              height: 150,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                decoration: const BoxDecoration(
                  color: Color(0xFFE9EEFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(5),
                  ),
                ),
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
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Image.asset('assets/question.png', height: 200),
            ),

            const SizedBox(height: 24),

            ...current['options'].map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => selectOption(option['value']),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF9A56),
                          Color(0xFFFF6B35),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(48),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      option['label'],
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}