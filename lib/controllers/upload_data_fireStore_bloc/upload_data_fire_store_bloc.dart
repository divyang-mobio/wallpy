import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../resources/resources.dart';

part 'upload_data_fire_store_event.dart';

part 'upload_data_fire_store_state.dart';

class UploadDataFireStoreBloc
    extends Bloc<UploadDataFireStoreEvent, UploadDataFireStoreState> {
  UploadDataFireStoreBloc() : super(UploadDataFireStoreInitial()) {
    on<UploadData>((event, emit) async {
      try {
        emit(UploadDataFireStoreProcess());
        await FirebaseFirestore.instance
            .collection(TextResources().fireStoreCategory)
            .add({
          "image_url": event.url,
          "image_name": event.name,
          "image_category": event.category,
          "image_fav": false,
          "image_id": DateTime.now().microsecondsSinceEpoch,
          "image_timestamp": DateTime.now(),
          "image_uid": FirebaseAuth.instance.currentUser?.uid,
          "month": event.months,
          "wallpy_unm": FirebaseAuth.instance.currentUser?.displayName
        });
        emit(UploadDataFireStoreSuccess());
      } catch (e) {
        emit(UploadDataFireStoreError());
      }
    });
    on<OnSubmitForUpload>((event, emit) => emit(UploadDataFireStoreInitial()));
  }
}
