import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// part 'counter_cubit_state.dart';

class CounterCubitCubit extends Cubit<int> {
  CounterCubitCubit({this.init = 1}) : super(init);
  int init;
  void increment(){
    emit(state + 1);
  }
  void decrement(){
    emit(state-1);
  }
}
