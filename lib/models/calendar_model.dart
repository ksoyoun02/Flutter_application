class CalendarModel {
  int? id; // nullable
  String? title;
  DateTime? eventDate;
  String? startTime;
  String? endTime;
  String? description;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAt;

  CalendarModel({
    this.id,
    this.title,
    this.eventDate,
    this.startTime,
    this.endTime,
    this.description,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  // JSON 데이터를 모델로 변환하는 생성자
  CalendarModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        eventDate = DateTime.parse(json['event_DATE']),
        startTime = json['start_TIME'],
        endTime = json['end_TIME'],
        description = json['description'],
        location = json['location'],
        createdAt = DateTime.parse(json['created_AT']),
        updatedAt = DateTime.parse(json['updated_AT']);

  // 모델 데이터를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'event_DATE': eventDate?.toIso8601String(),
      'start_TIME': startTime,
      'end_TIME': endTime,
      'description': description,
      'location': location,
      'created_AT': createdAt?.toIso8601String(),
      'updated_AT': updatedAt?.toIso8601String(),
    };
  }
}
