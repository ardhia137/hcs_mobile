import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hcs_mobile/model/CovidModel.dart';
import 'package:hcs_mobile/services/CovidServices.dart';

part 'covid_cubit_state.dart';

class CovidCubitCubit extends Cubit<CovidCubitState> {
  CovidCubitCubit() : super(CovidCubitInitial());
  void get_covid()async{
    try {
      emit(CovidCubitLoading());
      CovidModel covid = await CovidServices().get_covid();
      emit(CovidCubitSuccess(covid));
    } catch (e) {
      emit(CovidCubitGagal(e.toString()));
    }
  }
}
