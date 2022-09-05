import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bloc/bloc.dart';
import '../../models/data_model.dart';
import '../../resources/resources.dart';
import '../../utils/firestore_database_calling.dart';
import '../../utils/store_data.dart';
import '../../widgets/background_service.dart';
import '../../widgets/wallpaper_setter.dart';

part 'service_event.dart';

part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceLoading()) {
    on<OnChange>((event, emit) async {
      emit(ServiceLoaded(isOn: event.isOn));
      if (event.isOn) {
        List<DataModel> data =
            await FireStoreForBackgroundService().getAllData(event.isFavorite);
        final pref = PreferenceServices();
        pref.setScreen(event.screen);
        pref.setList(data);
        pref.setNo(1);
        pref.setToggle(true);
        wallpaperSetter(data[0].url, event.screen);
        await AndroidAlarmManager.periodic(const Duration(minutes: 1),
            TextResources().androidAlarmManagerId, callWallpaperSetter);
      } else {
        final pref = PreferenceServices();
        pref.setToggle(false);
        await AndroidAlarmManager.cancel(TextResources().androidAlarmManagerId);
      }
    });
    on<CheckService>((event, emit) async {
      emit(ServiceLoaded(isOn: await event.pref.getToggle()));
    });
  }
}
