part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];

  // get newPin => null;
  // get oldPin => null;
}


class AuthCheckEmail extends AuthEvent{
  final String email;

  const AuthCheckEmail(this.email);

  @override
  // TODO: implement props
  List<Object> get props => [email];
}

class AuthRegister extends AuthEvent {
  final SignUpFormModel data;

  const AuthRegister(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class AuthLogin extends AuthEvent{
  final SignInFormModel data;

  const AuthLogin(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class AuthgetCurrentUser extends AuthEvent{}

class AuthUpdateUser extends AuthEvent {
  final UserEditFormModel data;

  const AuthUpdateUser(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class AuthUpdatePin extends AuthEvent {
  final String oldPin;
  final String newPin;

  const AuthUpdatePin(this.oldPin, this.newPin);

  @override
  // TODO: implement props
  List<Object> get props => [oldPin, newPin];
}

class AuthLogout extends AuthEvent{}

// auth update balance
class AuthUpdateBalance extends AuthEvent {
  final int balance;

  const AuthUpdateBalance(this.balance);

  @override
  List<Object> get props => [balance];
}


