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

  // 주어진 날짜에 해당하는 일정을 가져오는 메서드
  Future<List<String>> getMonthlySchedules(int year, int month) async {
    String monthStr = month.toString().padLeft(2, '0');

    final Uri url =
        Uri.parse('$apiUrl/getMonthlySchedules?year=$year&month=$monthStr');

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          jsonDecode(utf8.decode(response.bodyBytes));
      return jsonData
          .map((item) => item['EVENT_DATE'] as String) // EVENT_DATE만 추출
          .toList();
    } else {
      throw Exception(
          'Failed to fetch schedules. Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> saveSchedules(CalendarModel scheduleData) async {
    // JSON 객체를 문자열로 변환
    String jsonString = json.encode(scheduleData.toJson());

    final response = await http.post(
      Uri.parse('$apiUrl/saveSchedule'), // API URL
      headers: {'Content-Type': 'application/json'},
      body: jsonString,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // 요청 실패 시
      throw Exception('저장에 실패했습니다. 서버 오류 발생');
    }
  }

  Future<Map<String, dynamic>> deleteSchedules(
      CalendarModel scheduleData) async {
    String jsonString = json.encode(scheduleData.toJson());

    final response = await http.post(
      Uri.parse('$apiUrl/deleteSchedules'), // API URL
      headers: {'Content-Type': 'application/json'},
      body: jsonString,
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // 요청 실패 시
      throw Exception('저장에 실패했습니다. 서버 오류 발생');
    }
  }
}
