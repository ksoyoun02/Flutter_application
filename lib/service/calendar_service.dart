import 'package:application/models/calendar_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ScheduleService {
  final String apiUrl =
      'http://10.0.2.2:8080/calendar/findScheduleList'; // API URL

  // 주어진 날짜에 해당하는 일정을 가져오는 메서드
  Future<List<CalendarModel>> getSchedules(DateTime selectedDate) async {
    final Map<String, dynamic> requestData = {
      'eventDate':
          '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}'
    };

    final request = http.Request('GET', Uri.parse(apiUrl))
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode(requestData);

    final streamedResponse = await http.Client().send(request);

    if (streamedResponse.statusCode == 200) {
      // 응답 데이터를 읽어 JSON으로 변환
      final responseBody = await streamedResponse.stream.bytesToString();
      final List<dynamic> jsonData = jsonDecode(responseBody);

      // JSON 데이터를 `CalendarModel` 리스트로 변환
      final List<CalendarModel> calendarData = jsonData
          .map((item) => CalendarModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return calendarData; // 변환된 데이터를 반환
    } else {
      throw Exception(
          'Failed to fetch calendar data. Status code: ${streamedResponse.statusCode}');
    }
  }

  // 주어진 날짜에 해당하는 일정을 가져오는 메서드
  Future<List<CalendarModel>> saveSchedules(DateTime selectedDate) async {
    final Map<String, dynamic> requestData = {
      'eventDate':
          '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}'
    };

    final request = http.Request('GET', Uri.parse(apiUrl))
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode(requestData);

    final streamedResponse = await http.Client().send(request);

    if (streamedResponse.statusCode == 200) {
      // 응답 데이터를 읽어 JSON으로 변환
      final responseBody = await streamedResponse.stream.bytesToString();
      final List<dynamic> jsonData = jsonDecode(responseBody);

      // JSON 데이터를 `CalendarModel` 리스트로 변환
      final List<CalendarModel> calendarData = jsonData
          .map((item) => CalendarModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return calendarData; // 변환된 데이터를 반환
    } else {
      throw Exception(
          'Failed to fetch calendar data. Status code: ${streamedResponse.statusCode}');
    }
  }
}
