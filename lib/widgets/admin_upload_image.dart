import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../resources/resources.dart';
import '../controllers/upload_image_bloc/upload_image_bloc.dart';
import 'alert_box.dart';

uploadImage(context) async {
  final firebaseStorage = FirebaseStorage.instance;
  final imagePicker = ImagePicker();
  XFile? image;
  await Permission.photos.request();
  var permissionStatus = await Permission.photos.status;
  if (permissionStatus.isGranted) {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // final bytes = await image.readAsBytes();
      // final kiloByte = (bytes.lengthInBytes / 1024);
      // final size = await decodeImageFromList(bytes);
      // final wHRatio = (size.width / size.height).toStringAsFixed(2);
      // final hWRatio = (size.height / size.width).toStringAsFixed(2);
      // if (kiloByte <= 100 && (wHRatio == "1.78" || hWRatio == "1.78")) {
        try {
          var file = File((image.path).toString());
          var snapshot = await firebaseStorage
              .ref()
              .child('${TextResources().imageStoreInStoragePath}${image.name}')
              .putFile(file);
          var downloadUrl = await snapshot.ref.getDownloadURL();
          BlocProvider.of<UploadImageBloc>(context)
              .add(GetImageUrl(url: downloadUrl, name: image.name));
        } catch (e) {
          BlocProvider.of<UploadImageBloc>(context).add(NotGetImageUrl());
        }
      // } else {
      //   BlocProvider.of<UploadImageBloc>(context)
      //       .add(NotGivePermissionOrImage());
      //   (kiloByte <= 100)
      //       ? await alertDialog(context, TextResources().imgSizeMore)
      //       : await alertDialog(context, TextResources().imgAspectRatio);
      // }
    } else {
      BlocProvider.of<UploadImageBloc>(context).add(NotGivePermissionOrImage());
      await alertDialog(context, TextResources().imgIsNotSelected);
    }
  } else {
    BlocProvider.of<UploadImageBloc>(context).add(NotGivePermissionOrImage());
    await alertDialog(context, TextResources().permissionIsNotGiven);
  }
}