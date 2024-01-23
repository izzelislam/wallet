import 'package:bank_sha/models/tips_model.dart';
import 'package:bank_sha/services/tips_servidce.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tips_event.dart';
part 'tips_state.dart';

class TipsBloc extends Bloc<TipsEvent, TipsState> {
  TipsBloc() : super(TipsInitial()) {
    on<TipsEvent>((event, emit) async{
      
      if (event is GetTipsEvent){
        try {
          emit(TipsLoading());

          final res = await TipsService().getTips();
          emit(TipsSuccess(res));
        } catch (e) {
          emit(TipsFailed(e.toString()));
        }
      }

    });
  }
}
