
import 'package:bank_sha/models/sign_in_form_model.dart';
import 'package:bank_sha/models/sign_up_form_model.dart';
import 'package:bank_sha/models/user_edit_form_model.dart';
import 'package:bank_sha/models/user_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/services/user_services.dart';
import 'package:bank_sha/services/wallet_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      
      if (event is AuthCheckEmail){
        try {

        	emit(AuthLoading());

          final res = await AuthService().checkEmail(event.email);

          if (res == false){
            emit(AuthCheckEmailSuccess());
          }else {
            emit(const AuthFailed('Email sudah terpakai'));
          }

        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthRegister){
        try {
          emit(AuthLoading());
          final res = await AuthService().register(event.data);

          emit(AuthSuccess(res));

        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogin){
        try {
          emit(AuthLoading());
          final res = await AuthService().login(event.data);

          emit(AuthSuccess(res));

        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthgetCurrentUser){
        try {
          emit(AuthLoading());

          final  SignInFormModel data = await AuthService().getCredentialFromLocal();
          final UserModel user = await AuthService().login(data);

          emit(AuthSuccess(user));

        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdateUser){
        try {

          if (state is AuthSuccess){
            final updatedUser = (state as AuthSuccess).data.copyWith(
              username: event.data.username,
              name: event.data.name,
              email: event.data.email,
              password: event.data.password,
            );

            emit(AuthLoading());
            await UserService().updateUser(event.data);

            await AuthService().storeCredentialToLocal(updatedUser);
            emit(AuthSuccess(updatedUser));
          }
          
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdatePin){
        try {
          
          if (state is AuthSuccess){
            final updatedUser = (state as AuthSuccess).data.copyWith(pin: event.newPin);

            emit(AuthLoading());
            await WalletService().updatePin(event.newPin, event.oldPin);
            emit(AuthSuccess(updatedUser));
          }

        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogout){
        try {
          
          emit(AuthLoading());
          await AuthService().logout();
          await AuthService().clearLocalStorage();
          emit(AuthInitial());

        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

       if (event is AuthUpdateBalance){
          if (state is AuthSuccess){
            final currentUser = (state as AuthSuccess).data;
            final updatedUser = currentUser.copyWith(
              balance: currentUser.balance! + event.balance,
            );
            emit(AuthSuccess(updatedUser));
          }
      }

    });
  }
}
