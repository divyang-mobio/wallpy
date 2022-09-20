import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../resources/resources.dart';
import '../controllers/upload_image_bloc/upload_image_bloc.dart';
import 'alert_box.dart';

void uploadImage(context) async {
  final imagePicker = ImagePicker();
  XFile? image;
  await Permission.photos.request();
  var permissionStatus = await Permission.photos.status;
  if (permissionStatus.isGranted) {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      final kiloByte = (bytes.lengthInBytes / 1024);
      final size = await decodeImageFromList(bytes);
      final wHRatio = (size.width / size.height).toStringAsFixed(2);
      final hWRatio = (size.height / size.width).toStringAsFixed(2);
      if (kiloByte <= 100) {
        if (wHRatio == "1.78" || hWRatio == "1.78") {
          uploadToFireStore(context, image.path, image.name);
        } else {
          final img = await cropImage(context, image);
          if (img != null) {
            uploadToFireStore(context, img.path, image.name);
          } else {
            errorMessage(context, TextResources().croppingImgError);
          }
        }
      }
    } else {
      errorMessage(context, TextResources().imgIsNotSelected);
    }
  } else {
    errorMessage(context, TextResources().permissionIsNotGiven);
  }
}

void uploadToFireStore(context, String path, String name) async {
  final firebaseStorage = FirebaseStorage.instance;
  try {
    var file = File(path);
    var snapshot = await firebaseStorage
        .ref()
        .child('${TextResources().imageStoreInStoragePath}$name')
        .putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    BlocProvider.of<UploadImageBloc>(context)
        .add(GetImageUrl(url: downloadUrl, name: name));
  } catch (e) {
    BlocProvider.of<UploadImageBloc>(context).add(NotGetImageUrl());
  }
}

Future<CroppedFile?> cropImage(context, XFile imageFile) async =>
    await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: TextResources().cropAppTitle,
              toolbarColor: BlocProvider
                  .of<DarkModeBloc>(context)
                  .isDark
                  ? ColorResources().appBarDark
                  : ColorResources().appBar,
              toolbarWidgetColor: BlocProvider
                  .of<DarkModeBloc>(context)
                  .isDark
                  ? ColorResources().appBarTextIconDark
                  : ColorResources().appBarTextIcon),
          IOSUiSettings(title: TextResources().cropAppTitle),
        ]);

void errorMessage(context, title) async {
  BlocProvider.of<UploadImageBloc>(context).add(NotGivePermissionOrImage());
  await alertDialog(context, title);
}
