part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

// get by username
class UserGetByUsername extends UserEvent {
  final String username;

  const UserGetByUsername(this.username);

  @override
  // TODO: implement props
  List<Object> get props => [username];
}

// get recent user
class UserGetRecentUser extends UserEvent {
}
