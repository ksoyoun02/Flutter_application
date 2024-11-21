class CalenderModel {
  final int id;
  final String title;
  final DateTime eventDate;
  final String startTime;
  final String endTime;
  final String description;
  final String location;
  final DateTime createdAt;
  final DateTime updatedAt;

  CalenderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        eventDate = DateTime.parse(json['event_DATE']),
        startTime = json['start_TIME'],
        endTime = json['end_TIME'],
        description = json['description'],
        location = json['location'],
        createdAt = DateTime.parse(json['created_AT']),
        updatedAt = DateTime.parse(json['updated_AT']);
}
