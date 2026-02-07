import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // TODO: 배포 시 실제 서버 URL로 변경
  // Android 에뮬레이터: 10.0.2.2:3000
  // iOS 시뮬레이터 / 웹: localhost:3000
  // 실제 기기: 서버 IP 또는 도메인
  static const String baseUrl = 'http://localhost:3000';

  /// 메뉴 추천 API 호출
  /// category: korean, japanese, chinese, western, etc
  /// taste: spicy, greasy, plain, etc
  /// methods: fried, grilled, soup, etc
  /// temp: hot, warm, cold
  static Future<Map<String, dynamic>?> getRecommendation({
    required String category,
    required String taste,
    required String methods,
    required String temp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/recommend'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'category': category,
          'taste': taste,
          'methods': methods,
          'temp': temp,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data['success'] == true) {
          return data['data'];
        }
      }
      return null;
    } catch (e) {
      print('API Error: $e');
      return null;
    }
  }

  /// 장소 검색 API 호출 (네이버 로컬 검색)
  static Future<List<Map<String, dynamic>>> searchPlaces(String query) async {
    try {
      final url = '$baseUrl/places?query=${Uri.encodeComponent(query)}';
      print('🔍 Calling API: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      print('🔍 Response Status: ${response.statusCode}');
      print('🔍 Response Body: ${utf8.decode(response.bodyBytes)}');

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data['success'] == true && data['data'] != null) {
          final places = data['data']['places'] as List;
          print('✅ Parsed ${places.length} places');
          return places.map((p) => Map<String, dynamic>.from(p)).toList();
        }
      }
      return [];
    } catch (e) {
      print('Places API Error: $e');
      return [];
    }
  }

  /// 피드백 제출 및 재추천 요청
  static Future<Map<String, dynamic>?> submitFeedback({
    required String menuName,
    required bool isLiked,
    required String additionalInfo,
    required Map<String, dynamic> originalChoices,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/feedback'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'previousMenu': menuName,
          'feedback': additionalInfo,
          'originalChoices': originalChoices,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data['success'] == true) {
          return data['data'];
        }
      }
      return null;
    } catch (e) {
      print('Feedback API Error: $e');
      return null;
    }
  }
}
