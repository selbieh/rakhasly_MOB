import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class CustomReactiveImagePicker extends StatelessWidget {
  final String formControlName;
  String? label;
  CustomReactiveImagePicker(
      {super.key, required this.formControlName, this.label});

  @override
  Widget build(BuildContext context) {
    return ReactiveImagePicker(
      formControlName: formControlName,
      modes: const [ImagePickerMode.galleryImage, ImagePickerMode.cameraImage],
      decoration: InputDecoration(
          labelText: label ?? 'Image',
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          helperText: ''),
      preprocessError: (e) async {
        if (e is PlatformException) {
          switch (e.code) {
            case 'photo_access_denied':
              await _photoDenied(context);
              break;
            case 'camera_access_denied':
              await _cameraDenied(context);
              break;
          }
        }
      },
      inputBuilder: (onPressed) => TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: Text('Add an image'.tr),
      ),
    );
  }

  Future<void> _photoDenied(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Photo access required'.tr),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Open settings to allow access'.tr,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('Settings'.tr),
                onPressed: () async {
                  await AppSettings.openAppSettings();
                  Get.back();
                },
              ),
            ],
          );
        },
      );

  Future<void> _cameraDenied(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Camera access required'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Open settings to allow access',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Settings'),
                onPressed: () async {
                  await AppSettings.openAppSettings();
                  Get.back();
                },
              ),
            ],
          );
        },
      );
}
