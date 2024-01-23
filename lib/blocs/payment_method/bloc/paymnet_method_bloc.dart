import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/services/payment_method_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'paymnet_method_event.dart';
part 'paymnet_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(PaymentMethodInitial()) {
    on<PaymentMethodEvent>((event, emit) async {
      
      if (event is PaymentMethodGet){
        try {
          emit(PaymentMethodLoading());
          final res = await PaymentMethodService().getPaymentMethods();
          emit(PaymentMethodSuccess(res));
        } catch (e) {
          emit(PaymentMethodFailed(e.toString()));
        }
      }

    });
  }
}
