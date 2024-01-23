part of 'paymnet_method_bloc.dart';

sealed class PaymentMethodState extends Equatable {
  const PaymentMethodState();
  
  @override
  List<Object> get props => [];
}

final class PaymentMethodInitial extends PaymentMethodState {}
final class PaymentMethodLoading extends PaymentMethodState {}

final class PaymentMethodFailed extends PaymentMethodState {
  final String e;

  const PaymentMethodFailed(this.e);

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

final class PaymentMethodSuccess extends PaymentMethodState {
  final List<PaymentMethodModel> data;

  const PaymentMethodSuccess(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}
