import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hcs_mobile/services/UsersServices.dart';

// part 'counter_cubit_state.dart';

class SelectProductCubit extends Cubit<bool> {
  SelectProductCubit({this.init = false}) : super(init);
  bool init;
  void checked(){
    emit(!state);
  }
}
class TotalProductCubit extends Cubit<int> {
  TotalProductCubit() : super(0);
  // int init;
  void checked(int? total){
    // print(init);
    emit(total!);
  }
}


