import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../resources/resources.dart';
part 'upload_data_fire_store_event.dart';
part 'upload_data_fire_store_state.dart';

class UploadDataFireStoreBloc
    extends Bloc<UploadDataFireStoreEvent, UploadDataFireStoreState> {
  UploadDataFireStoreBloc() : super(UploadDataFireStoreInitial()) {
    on<UploadData>((event, emit) async {
      try {
        emit(UploadDataFireStoreProcess());
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection(TextResources().fireStoreCategory)
            .get();
        final documents =
            result.docs.map((e) => int.parse(e.id.trim())).toList();
        documents.sort();
        print('ajkhsdjajmdjad----${documents.last + 1}');
        await FirebaseFirestore.instance
            .collection(TextResources().fireStoreCategory)
            .doc((documents.last + 1).toString())
            .set({
          "image_url": event.url,
          "image_name": event.name,
          "image_category": event.category,
          "image_fav": false,
          "month": event.month,
          "image_id": DateTime.now().microsecondsSinceEpoch,
          "image_timestamp": DateTime.now(),
          "image_uid": "divyang",
          "wallpy_unm": ""
        });
        emit(UploadDataFireStoreSuccess());
      } catch (e) {
        emit(UploadDataFireStoreError());
      }
    });
    on<OnSubmitForUpload>((event, emit) => emit(UploadDataFireStoreInitial()));
  }
}
