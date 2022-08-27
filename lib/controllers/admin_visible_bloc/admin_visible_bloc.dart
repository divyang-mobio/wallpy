import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/firestore_database_calling.dart';
import '../../utils/store_data.dart';

part 'admin_visible_event.dart';

part 'admin_visible_state.dart';

class AdminVisibleBloc extends Bloc<AdminVisibleEvent, AdminVisibleState> {
  final user = FirebaseAuth.instance;
  CheckAdminFireBase checkAdminFireBase;
  PreferenceServices pref;

  AdminVisibleBloc(this.checkAdminFireBase, this.pref)
      : super(AdminVisibleLoading()) {
    on<SetAdmin>((event, emit) async {
      pref.setAdmin(
          await checkAdminFireBase.getData(user.currentUser?.email ?? ""));
      (await pref.getAdmin())
          ? emit(AdminVisibleTrue())
          : emit(AdminVisibleFalse());
    });
    on<UnSetAdmin>((event, emit) async {
      pref.setAdmin(false);
      emit(AdminVisibleFalse());
    });
    on<CheckAdmin>((event, emit) async {
      (await pref.getAdmin())
          ? emit(AdminVisibleTrue())
          : emit(AdminVisibleFalse());
    });
  }
}
