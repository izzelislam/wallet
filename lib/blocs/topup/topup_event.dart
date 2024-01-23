part of 'topup_bloc.dart';

sealed class TopupEvent extends Equatable {
  const TopupEvent();

  @override
  List<Object> get props => [];
}

// event to topup
class TopUpPost extends TopupEvent {

  final TopUpFormModel data;

  const TopUpPost(this.data);

  @override
  List<Object> get props => [data];

}
