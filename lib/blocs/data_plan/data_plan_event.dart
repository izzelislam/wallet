part of 'data_plan_bloc.dart';

sealed class DataPlanEvent extends Equatable {
  const DataPlanEvent();

  @override
  List<Object> get props => [];
}


// post data plan
class PostDataPlant extends DataPlanEvent {
  final DataPlanFormModel data;

  const PostDataPlant(this.data);

  @override
  List<Object> get props => [data];
}