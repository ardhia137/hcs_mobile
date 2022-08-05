import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ChangePageCubit extends Cubit<int> {
  ChangePageCubit() : super(0);
  void setPage(int newPage) {
    emit(newPage);
  }
}