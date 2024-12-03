import 'package:flutter/material.dart';

class EmoticonSticker extends StatefulWidget {
  /* VoidCallback : 매개변수가 없고, 리턴값도 없는 함수
   *  이벤트 처리, 콜백 함수 등을 정의할 때 주로 사용
   */
  final VoidCallback onTransform;
  final String imgPath;
  final bool isSelected;

  const EmoticonSticker({
    super.key,
    required this.onTransform,
    required this.imgPath,
    required this.isSelected,
  });

  @override
  State<EmoticonSticker> createState() => _EmoticonStickerState();
}

class _EmoticonStickerState extends State<EmoticonSticker> {
  double scale = 1;
  double hTransform = 0;
  double vTransform = 0;
  double actualScale = 1;

  @override
  Widget build(BuildContext context) {
    // GestureDetector : 제스처 이벤트 감지 및 처리용 위젯
    return Transform(
      transform: Matrix4.identity()
        ..translate(hTransform, vTransform)
        ..scale(scale, scale),
      child: Container(
        decoration: widget.isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  color: Colors.blue,
                  width: 1.0,
                ),
              )
            : BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.transparent,
                ),
              ),
        child: GestureDetector(
          onTap: () {
            widget.onTransform();
          },
          // ScaleUpdateDetails : 스케일 제스처(두 손가락으로 확대/축소하는 제스처)를 수행할 때 발생
          onScaleUpdate: (ScaleUpdateDetails details) {
            widget.onTransform();
            setState(() {
              scale = details.scale * actualScale;
              vTransform += details.focalPointDelta.dy;
              hTransform += details.focalPointDelta.dx;
            });
          },
          onScaleEnd: (ScaleEndDetails details) {
            actualScale = scale;
          },
          child: Image.asset(
            widget.imgPath,
          ),
        ),
      ),
    );
  }
}
