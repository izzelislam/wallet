import 'package:bank_sha/models/operator_card_model.dart';
import 'package:bank_sha/services/operator_card_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'operator_card_event.dart';
part 'operator_card_state.dart';

class OperatorCardBloc extends Bloc<OperatorCardEvent, OperatorCardState> {
  OperatorCardBloc() : super(OperatorCardInitial()) {
    on<OperatorCardEvent>((event, emit) async {
      
      if (event is GetOperatorCard){
        try {
          emit(OperatorCardLoading());
          final res = await OperatorCardService().getOperator();
          emit(OperatorCardSuccess(res));
        } catch (e) {
          emit(OperatorCardFailed(e.toString()));
        }
      }

    });
  }
}
