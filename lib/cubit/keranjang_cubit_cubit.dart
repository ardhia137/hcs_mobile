import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hcs_mobile/model/KeranjangModel.dart';
import 'package:hcs_mobile/services/UsersServices.dart';

part 'keranjang_cubit_state.dart';

class KeranjangCubitCubit extends Cubit<KeranjangCubitState> {
  KeranjangCubitCubit() : super(KeranjangCubitInitial());
  void add_keranjang({required String email, required int id_produk, required int jumlah})async{
    try {
      emit(KeranjangCubitLoading());
      bool isSuksess =  await UsersServices().add_keranjang(email: email,id_produk: id_produk,jumlah: jumlah);
      emit(KeranjangCubitSuccess(isSuksess));
    } catch (e) {
      emit(KeranjangCubitGagal(e.toString()));
    }
  }

  void get_keranjang({required String email}) async {
    try {
       emit(KeranjangCubitLoading());
      List<KeranjangModel> keranjang = await UsersServices().get_keranjang(email: email);
      emit(GetKeranjangCubitSuccess(keranjang));
    } catch (e) {
      emit(KeranjangCubitGagal(e.toString()));
    }
  }

  void delete_keranjang({required int id_keranjang}) async{
    try {
      // emit(KeranjangCubitLoading());
      // bool isSuksess = 
      await UsersServices().delete_keranjang(id_keranjang: id_keranjang);
      // emit(UpdateKeranjangCubitSuccess(isSuksess));
    } catch (e) {
      emit(KeranjangCubitGagal(e.toString()));
    }
  }
}
