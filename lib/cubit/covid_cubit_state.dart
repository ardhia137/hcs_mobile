part of 'covid_cubit_cubit.dart';

abstract class CovidCubitState extends Equatable {
  const CovidCubitState();

  @override
  List<Object> get props => [];
}

class CovidCubitInitial extends CovidCubitState {}

class CovidCubitLoading extends CovidCubitState{}

class CovidCubitSuccess extends CovidCubitState{
  final CovidModel covid;
  const CovidCubitSuccess(this.covid);

  @override
  // TODO: implement props
  List<Object> get props => [covid];
}
class CovidCubitGagal extends CovidCubitState{
  final String error;
  const CovidCubitGagal(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}