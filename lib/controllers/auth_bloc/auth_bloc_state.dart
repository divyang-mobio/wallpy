part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState extends Equatable {}

class AuthBlocInitial extends AuthBlocState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthBlocState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthBlocState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthBlocState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
