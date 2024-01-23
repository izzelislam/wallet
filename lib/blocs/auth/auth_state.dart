part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailed extends AuthState {
  final String e ; 

  const AuthFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class AuthCheckEmailSuccess extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserModel data;

  const AuthSuccess(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}


