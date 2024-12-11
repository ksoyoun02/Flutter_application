import 'package:application/component/custom_text_field.dart';
import 'package:application/const/colors.dart';
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
                const CustomTextField(
                  label: '일정제목',
                  isTime: false,
                  oneLow: true,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                CustomTextField(
                    label: '일자',
                    isTime: false,
                    oneLow: true,
                    eventDate: widget.eventDate,
                    isDisabled: true),
                const SizedBox(
                  height: 8.0,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: '시작시간',
                        isTime: true,
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: CustomTextField(
                        label: '종료시간',
                        isTime: true,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const CustomTextField(
                  label: '장소',
                  isTime: false,
                  oneLow: true,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const CustomTextField(
                  label: '내용',
                  isTime: false,
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

  void onSaveButton() {}
}
