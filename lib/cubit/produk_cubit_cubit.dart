import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hcs_mobile/model/PordukModel.dart';
import 'package:hcs_mobile/services/ProdukServices.dart';

part 'produk_cubit_state.dart';

class ProdukCubitCubit extends Cubit<ProdukCubitState> {
  ProdukCubitCubit() : super(ProdukCubitInitial());
  void get_produk(int limit)async{
    try {
      emit(ProdukCubitLoading());
      List<ProdukModel> produk = await ProdukServices().get_produk(limit);
      emit(ProdukCubitSuccess(produk));
    } catch (e) {
      emit(ProdukCubitGagal(e.toString()));
    }
  }
}