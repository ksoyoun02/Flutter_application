import 'package:application/component/custom_text_field.dart';
import 'package:application/const/colors.dart';
import 'package:application/models/calendar_model.dart';
import 'package:application/service/calendar_service.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime eventDate;

  const ScheduleBottomSheet({
    super.key,
    required this.eventDate,
  });

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final service = ScheduleService();

  late TextEditingController _titleController;
  late TextEditingController _eventDateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    // 각 필드에 대한 TextEditingController 초기화
    _titleController = TextEditingController();
    _eventDateController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
    _locationController = TextEditingController();
    _descriptionController = TextEditingController();

    _eventDateController.text =
        widget.eventDate.toLocal().toString().split(' ')[0];
  }

  @override
  void dispose() {
    // 메모리 해제
    _titleController.dispose();
    _eventDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottonInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 2 + bottonInset,
        color: Colors.white,
        child: Padding(
          padding:
              EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottonInset),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "일정등록",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomTextField(
                  label: '일정제목',
                  isTime: false,
                  oneLow: true,
                  controller: _titleController,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomTextField(
                    label: '일자',
                    isTime: false,
                    oneLow: true,
                    controller: _eventDateController,
                    isDisabled: true),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: '시작시간',
                        isTime: true,
                        controller: _startTimeController,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: CustomTextField(
                        label: '종료시간',
                        isTime: true,
                        controller: _endTimeController,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomTextField(
                  label: '장소',
                  isTime: false,
                  oneLow: true,
                  controller: _locationController,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomTextField(
                  label: '내용',
                  isTime: false,
                  controller: _descriptionController,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSaveButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                    ),
                    child: const Text('저장'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSaveButton() {
    // 각 TextEditingController에서 값을 가져옴
    String title = _titleController.text;
    String eventDate = _eventDateController.text;
    String startTime = _startTimeController.text;
    String endTime = _endTimeController.text;
    String location = _locationController.text;
    String description = _descriptionController.text;

    // 여기서 원하는 대로 데이터를 처리할 수 있습니다.
    print('Title: $title');
    print('eventDate: $eventDate');
    print('Start Time: $startTime');
    print('End Time: $endTime');
    print('Place: $location');
    print('Content: $description');

    CalendarModel scheduleData = CalendarModel(
      title: title,
      eventDate: DateTime.parse(eventDate),
      startTime: startTime,
      endTime: endTime,
      location: location,
      description: description,
    );

    service.saveSchedules(scheduleData);
  }
}
