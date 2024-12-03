import 'dart:io';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:application/component/emoticon_sticker.dart';
import 'package:application/component/footer.dart';
import 'package:application/component/main_app_bar.dart';
import 'package:application/models/sticker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

class ImageEditorScreen extends StatefulWidget {
  const ImageEditorScreen({super.key});

  @override
  State<ImageEditorScreen> createState() => _ImageEditorScreenState();
}

class _ImageEditorScreenState extends State<ImageEditorScreen> {
  XFile? image;
  Set<StickerModel> stickers = {};
  String? selectedId;
  GlobalKey imgKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          renderBody(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteItem,
            ),
          ),
          if (image != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Footer(onEmoticonTap: onEmoticonTap),
            )
        ],
      ),
    );
  }

  Widget renderBody() {
    if (image != null) {
      return RepaintBoundary(
        key: imgKey,
        child: Positioned.fill(
          child: InteractiveViewer(
            child: InteractiveViewer(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(image!.path),
                    fit: BoxFit.cover,
                  ),
                  ...stickers.map(
                    (sticker) => Center(
                      child: EmoticonSticker(
                        key: ObjectKey(sticker.id),
                        onTransform: () {
                          onTransform(sticker.id);
                        },
                        imgPath: sticker.imgPath,
                        isSelected: selectedId == sticker.id,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: TextButton(
          onPressed: onPickImage,
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          child: const Text('이미지 선택하기'),
        ),
      );
    }
  }

  void onEmoticonTap(int index) async {
    setState(
      () {
        stickers = {
          ...stickers,
          StickerModel(
            id: const Uuid().v4(),
            imgPath: 'asset/img/emoticon_$index.png',
          )
        };
      },
    );
  }

  void onPickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      this.image = image;
    });
  }

  void onSaveImage() async {
    RenderRepaintBoundary boundary =
        imgKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png); // ➋ byte data 형태로 형태 변경
    Uint8List pngBytes =
        byteData!.buffer.asUint8List(); // ➌ Unit8List 형태로 형태 변경

    await PhotoManager.editor.saveImage(pngBytes, filename: '');

    ScaffoldMessenger.of(context).showSnackBar(
      // ➋ 저장 후 Snackbar 보여주기
      const SnackBar(
        content: Text('저장되었습니다!'),
      ),
    );
  }

  void onDeleteItem() async {
    setState(() {
      stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();
    });
  }

  void onTransform(String id) {
    setState(() {
      selectedId = id;
    });
  }
}
