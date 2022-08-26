import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/upload_image_bloc/upload_image_bloc.dart';
import '../resources/resources.dart';
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
      // final kb = (bytes.lengthInBytes / 1024);
      // if (kb <= 100) {
        var file = File((image.path).toString());
        var snapshot = await firebaseStorage
            .ref()
            .child('image/${image.name}')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        BlocProvider.of<UploadImageBloc>(context)
            .add(GetImageUrl(url: downloadUrl));
        // await FirebaseFirestore.instance
        //     .collection(TextResources().fireStoreCategory)
        //     .add({
        //   "image_url": downloadUrl,
        //   "image_name": image.name,
        //   "image_category": ["test", "War"],
        //   "image_fav": false,
        //   "image_id": DateTime.now().microsecondsSinceEpoch,
        //   "image_timestamp": DateTime.now(),
        //   "image_uid": FirebaseAuth.instance.currentUser?.uid,
        //   "wallpy_unm": FirebaseAuth.instance.currentUser?.displayName
        // });
      // } else {
      //   await alertDialog(context, 'Image Size is more than 100kb');
      // }
    } else {
      await alertDialog(context, 'No Image Path Received');
    }
  } else {
    await alertDialog(
        context, 'Permission not granted. Try Again with permission access');
  }
}
