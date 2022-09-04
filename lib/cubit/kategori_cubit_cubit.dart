import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hcs_mobile/model/KategoriModel.dart';
import 'package:hcs_mobile/services/KategoriServices.dart';

part 'kategori_cubit_state.dart';

class KategoriCubitCubit extends Cubit<KategoriCubitState> {
  KategoriCubitCubit() : super(KategoriCubitInitial());
    void get_kategori()async{
    try {
     emit(KategoriCubitLoading());
      List<KategoriModel> kategori = await KategoriServices().get_kategori();
      emit(KategoriCubitSuccess(kategori));
    } catch (e) {
      emit(KategoriCubitGagal(e.toString()));
    }
  }
}
