import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hcs_mobile/services/UsersServices.dart';

part 'keranjang_cubit_state.dart';

class KeranjangCubitCubit extends Cubit<KeranjangCubitState> {
  KeranjangCubitCubit() : super(KeranjangCubitInitial());
  void keranjang({required String email, required int id_produk, required int jumlah})async{
    try {
      emit(KeranjangCubitLoading());
      bool isSuksess =  await UsersServices().keranjang(email: email,id_produk: id_produk,jumlah: jumlah);
      emit(KeranjangCubitSuccess(isSuksess));
    } catch (e) {
      emit(KeranjangCubitGagal(e.toString()));
    }
  }
}
