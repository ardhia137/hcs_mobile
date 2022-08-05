import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hcs_mobile/model/UsersModel.dart';
import 'package:hcs_mobile/services/UsersServices.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit() : super(AuthCubitInitial());
  void clear(){
    emit(AuthCubitInitial());
  }
  void login({required String email})async{
    try {
      emit(AuthCubitLoading());
      UserModel user = await UsersServices().login(email: email);
      emit(AuthCubitSuccess(user));
    } catch (e) {
      emit(AuthCubitGagal(e.toString()));
    }
  }
  void reset({required String email})async{
      emit(AuthCubitGagal('reset'));
  }
}


class Getpassword extends Cubit<bool> {
  Getpassword() : super(false);
  void getpassword(bool value) {
    emit(value);
  }
}
