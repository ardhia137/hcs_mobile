import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hcs_mobile/model/UsersModel.dart';
import 'package:hcs_mobile/services/UsersServices.dart';

part 'register_cubit_state.dart';

class RegisterCubitCubit extends Cubit<RegisterCubitState> {
  RegisterCubitCubit() : super(RegisterCubitInitial());
  void register({required String email})async{
    try {
      emit(RegisterCubitLoading());
      bool isSuksess = await UsersServices().register(email: email);
      emit(RegisterCubitSuccess(isSuksess));
    } catch (e) {
      emit(RegisterCubitGagal(e.toString()));
    }
  }
}
class RequestOtpCubitCubit extends Cubit<RequestOtpCubitState> {
  RequestOtpCubitCubit() : super(RequestOtpCubitInitial());
   void request_otp({required String email})async{
    try {
      emit(RequestOtpCubitLoading());
      UserModel user =  await UsersServices().request_otp(email: email);
      emit(RequestOtpCubitSuccess(user));
    } catch (e) {
      emit(RequestOtpCubitGagal(e.toString()));
    }
  }
  }
  
  class CompleteAuthCubitCubit extends Cubit<CompleteAuthCubitState> {
  CompleteAuthCubitCubit() : super(CompleteAuthCubitInitial());
   void completeauth({required String email, required String nama, required String password})async{
    try {
      emit(CompleteAuthCubitLoading());
      bool isSuksess =  await UsersServices().complete_auth(email: email, nama: nama, password: password);
      emit(CompleteAuthCubitSuccess(isSuksess));
    } catch (e) {
      emit(CompleteAuthCubitGagal(e.toString()));
    }
  }
  }