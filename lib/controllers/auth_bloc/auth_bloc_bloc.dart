import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallpy/utils/auth_repository.dart';

part 'auth_bloc_event.dart';

part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepository authRepository;
  final GoogleSignIn googleSignIn;
  GoogleSignInAccount? googleSignInAccount;

  AuthBlocBloc({required this.authRepository, required this.googleSignIn})
      : super(UnAuthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthBlocInitial());
      try {
        await authRepository.signInWithEmail(event.email, event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthBlocInitial());
      try {
        await authRepository.signUpWithEmail(
            event.email, event.password, event.name);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((
      event,
      emit,
    ) async {
      on<GoogleSignUpRequested>((event, emit) async {
        emit(AuthBlocInitial());
        try {
          googleSignInAccount = await googleSignIn.signIn();
          if (googleSignInAccount == null) {
            emit(UnAuthenticated());
          }
          final googleAuth = await googleSignInAccount?.authentication;
          final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken);
          await FirebaseAuth.instance.signInWithCredential(credential);
          emit(Authenticated());
        } catch (e) {
          emit(AuthError(e.toString()));
          emit(UnAuthenticated());
        }
      });

      on<SignOutRequested>((event, emit) async {
        emit(AuthBlocInitial());
        await googleSignIn.signOut();
        await authRepository.logout();

        emit(UnAuthenticated());
      });
    });
  }
}
