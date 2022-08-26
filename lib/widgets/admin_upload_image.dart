import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
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
      final kb = (await image.length() / 1024);
      if (kb <= 100) {
        try {
          var file = File((image.path).toString());
          var snapshot = await firebaseStorage
              .ref()
              .child('image/${image.name}')
              .putFile(file);
          var downloadUrl = await snapshot.ref.getDownloadURL();
          BlocProvider.of<UploadImageBloc>(context)
              .add(GetImageUrl(url: downloadUrl, name: image.name));
        } catch (e) {
          BlocProvider.of<UploadImageBloc>(context).add(NotGetImageUrl());
        }
      } else {
        BlocProvider.of<UploadImageBloc>(context)
            .add(NotGivePermissionOrImage());
        await alertDialog(context, TextResources().imgSizeMore);
      }
    } else {
      BlocProvider.of<UploadImageBloc>(context).add(NotGivePermissionOrImage());
      await alertDialog(context, TextResources().imgIsNotSelected);
    }
  } else {
    BlocProvider.of<UploadImageBloc>(context).add(NotGivePermissionOrImage());
    await alertDialog(context, TextResources().permissionIsNotGiven);
  }
}
