import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/services/user_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit)async {
      
      if (event is UserGetByUsername){
        try {
          emit(UserLoading());

          final res = await UserService().getUserByUsername(event.username);

          emit(UserSuccess(res));
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }

      if (event is UserGetRecentUser){
        try {
          emit(UserLoading());

          final res = await UserService().getRecentUsers();

          emit(UserSuccess(res));

        } catch (e) {
          emit(UserFailed(e.toString()));
        }

      }

    });
  }
}
