import 'dart:ffi';

import 'package:application/models/calendar_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ScheduleService {
  final String apiUrl = 'http://10.0.2.2:8080/calendar'; // API URL

  // 주어진 날짜에 해당하는 일정을 가져오는 메서드
  Future<List<CalendarModel>> getSchedules(DateTime selectedDate) async {
    final String eventDate =
        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';

    final Uri url = Uri.parse('$apiUrl/findScheduleList?eventDate=$eventDate');

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          jsonDecode(utf8.decode(response.bodyBytes));
      return jsonData
          .map((item) => CalendarModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
          'Failed to fetch schedules. Status code: ${response.statusCode}');
    }
  }

  Future<String> saveSchedules(CalendarModel scheduleData) async {
    // JSON 객체를 문자열로 변환
    String jsonString = json.encode(scheduleData.toJson());

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/saveSchedule'), // API URL
        headers: {'Content-Type': 'application/json'},
        body: jsonString,
      );
      if (response.statusCode == 200) {
        // 요청 성공 시
        print('일정이 서버에 저장되었습니다.');
      } else {
        // 요청 실패 시
        throw Exception('저장에 실패했습니다. 서버 오류 발생');
      }
      return '일정이 저장되었습니다.';
    } catch (e) {
      return '오류 발생: $e';
    }
  }
}
