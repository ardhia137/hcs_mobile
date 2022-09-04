import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hcs_mobile/model/SearchModel.dart';
import 'package:hcs_mobile/services/SearchServices.dart';

part 'search_cubit_state.dart';

class SearchCubitCubit extends Cubit<SearchCubitState> {
  SearchCubitCubit() : super(SearchCubitInitial());
  void search({required String search}) async {
    try {
       List<SearchModel>? b = await SearchServices().insertdata(search: search);
       SearchSuccess(b!);
    } catch (e) {
      print(e);
    }
  }
  void getData() async{
    try {
      List<SearchModel> data = await SearchServices().getdata();
      emit(SearchSuccess(data));
    } catch (e) {
      print(e);
      emit(SearchGagal(e.toString()));
    }
  } 
  void delete({required int? id}) async{
    try {
      List<SearchModel> data = await SearchServices().delete(id:id);
      emit(SearchDeleteSuccess(data));
    } catch (e) {
      print(e);
      emit(SearchGagal(e.toString()));
    }
  } 
  void deleteall() async{
    try {
      List<SearchModel> data = await SearchServices().deleteall();
      emit(SearchDeleteSuccess(data));
    } catch (e) {
      print(e);
      emit(SearchGagal(e.toString()));
    }
  }
}
