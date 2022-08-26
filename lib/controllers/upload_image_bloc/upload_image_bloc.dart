import 'package:bloc/bloc.dart';

part 'upload_image_event.dart';

part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  UploadImageBloc() : super(UploadImageInitial()) {
    on<GetImageUrl>((event, emit) =>
        emit(UploadImageLoaded(url: event.url, name: event.name)));
    on<NotGetImageUrl>((event, emit) => emit(UploadImageError()));
    on<OnButtonClick>((event, emit) => emit(OnUploadButtonClick()));
  }
}
