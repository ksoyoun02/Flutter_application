class CalendarModel {
  int? id; // nullable
  String? title;
  String? eventDate;
  String? startTime;
  String? endTime;
  String? description;
  String? location;

  CalendarModel({
    this.id,
    this.title,
    this.eventDate,
    this.startTime,
    this.endTime,
    this.description,
    this.location,
  });

  // JSON 데이터를 모델로 변환하는 생성자
  CalendarModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        eventDate = json['eventDate'],
        startTime = json['startTime'].toString().substring(0, 5),
        endTime = json['endTime'].toString().substring(0, 5),
        description = json['description'],
        location = json['location'];

  // 모델 데이터를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'eventDate': eventDate,
      'startTime': startTime,
      'endTime': endTime,
      'description': description,
      'location': location,
    };
  }
}
