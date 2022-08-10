import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../repository/auth_repository.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepository authRepository;
  AuthBlocBloc({required this.authRepository}) : super(UnAuthenticated()) {
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
      emit(AuthBlocInitial());
      await authRepository.logout();

      emit(UnAuthenticated());
    });
  }
}
