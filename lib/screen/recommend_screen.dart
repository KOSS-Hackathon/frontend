import 'package:flutter/material.dart';
import 'package:menurecommend/screen/start_screen.dart';
import 'package:menurecommend/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendScreen extends StatefulWidget {
  final String menuName;
  
  const RecommendScreen({super.key, required this.menuName});

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  List<Map<String, dynamic>> places = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  Future<void> _loadPlaces() async {
    final result = await ApiService.searchPlaces(widget.menuName);
    setState(() {
      places = result;
      isLoading = false;
    });
  }

  Future<void> _openLink(String? link) async {
    if (link == null || link.isEmpty) return;
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image.asset('assets/result.png', height: 150),
                  const SizedBox(height: 20),
                  
                  // 헤더
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5B8DEF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '🏪 추천 가게',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '국민대 근처 "${widget.menuName}" 맛집',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // 가게 목록
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('가게를 검색하는 중...'),
                        ],
                      ),
                    )
                  else if (places.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(40),
                      child: const Text(
                        '주변에 가게를 찾을 수 없습니다 😢',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  else
                    ...places.map((place) => _buildPlaceCard(place)).toList(),
                  
                  const SizedBox(height: 30),
                  
                  // 종료 버튼
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => StartScreen()),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        '처음으로',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceCard(Map<String, dynamic> place) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 가게 이름
          Text(
            place['name'] ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 8),
          
          // 카테고리
          if (place['category'] != null && place['category'].toString().isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                place['category'],
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          const SizedBox(height: 8),
          
          // 주소
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  place['address'] ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          // 링크 버튼
          if (place['link'] != null && place['link'].toString().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: GestureDetector(
                onTap: () => _openLink(place['link']),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5B8DEF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '자세히 보기 →',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
