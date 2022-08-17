part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthBlocEvent {
  final String email;
  final String password;

  SignInRequested(
    this.email,
    this.password,
  );
}

class GoogleSignUpRequested extends AuthBlocEvent {}

class SignUpRequested extends AuthBlocEvent {
  final String email;
  final String password;
  final String name;
  SignUpRequested(this.email, this.password, this.name);
}

class SignOutRequested extends AuthBlocEvent {}
