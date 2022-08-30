import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hcs_mobile/services/UsersServices.dart';

// part 'counter_cubit_state.dart';

class CounterCubitCubit extends Cubit<int> {
  CounterCubitCubit({this.init = 1}) : super(init);
  int init;
  void increment({required int id_keranjang}){
    int jumlah = state+1;
    UsersServices().update_keranjang(id_keranjang: id_keranjang, jumlah: jumlah);
    emit(jumlah);
  }
  void update({required int id_keranjang}){
    int jumlah = state;
    UsersServices().update_keranjang(id_keranjang: id_keranjang, jumlah: jumlah);
    emit(jumlah);
  }
  void decrement({required int id_keranjang}){
    int jumlah = state-1;
    if (jumlah > 1) {  
    UsersServices().update_keranjang(id_keranjang: id_keranjang, jumlah: jumlah);
    }
    emit(jumlah);
  }
}
