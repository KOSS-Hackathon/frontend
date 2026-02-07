import 'package:flutter/material.dart';
import 'package:menurecommend/screen/addQuestion_screen.dart';
import 'package:menurecommend/screen/recommend_screen.dart';
import 'package:menurecommend/services/api_service.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> menuData;

  const ResultScreen({super.key, required this.menuData});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    // API 응답에서 menu 객체 추출
    final menu = widget.menuData['menu'] ?? widget.menuData;
    final menuName = menu['name'] ?? '추천 메뉴';
    final content = menu['content'] ?? '';
    final style = menu['style'] is List ? (menu['style'] as List).join(', ') : menu['style'] ?? '';
    final taste = menu['taste'] is List ? (menu['taste'] as List).join(', ') : menu['taste'] ?? '';
    final methods = menu['methods'] is List ? (menu['methods'] as List).join(', ') : menu['methods'] ?? '';
    final temperature = menu['temperature'] is List ? (menu['temperature'] as List).join(', ') : menu['temperature'] ?? '';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Image.asset('assets/result.png', height: 200),
                  const SizedBox(height: 20),
                  
                  // 메뉴 정보 카드
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: const Color(0xFFE5E7EB), width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // 메뉴 이름
                        Text(
                          menuName,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2B2B2B),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // 메뉴 설명
                        if (content.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6F7FB),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              content,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        const SizedBox(height: 20),
                        
                        // 태그들
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          children: [
                            if (style.isNotEmpty) _buildTag('🍽️ $style'),
                            if (taste.isNotEmpty) _buildTag('👅 $taste'),
                            if (methods.isNotEmpty) _buildTag('🔪 $methods'),
                            if (temperature.isNotEmpty) _buildTag('🌡️ $temperature'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // 버튼들
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 만족 버튼
                      GestureDetector(
                        onTap: () async {
                          // 피드백 전송
                          await ApiService.submitFeedback(
                            menuName: menuName,
                            isLiked: true,
                            additionalInfo: '만족합니다',
                            originalChoices: widget.menuData['input'] ?? {},
                          );
                          
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecommendScreen(menuName: menuName),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 140,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF5B8DEF),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            '만족 👍',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // 불만족 버튼
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddquestionScreen(
                                menuName: menuName,
                                originalChoices: widget.menuData['input'] ?? {},
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 140,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF5A5F),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            '불만족 👎',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EEFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF5B8DEF),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
