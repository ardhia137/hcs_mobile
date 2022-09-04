part of 'search_cubit_cubit.dart';

abstract class SearchCubitState extends Equatable {
  const SearchCubitState();

  @override
  List<Object> get props => [];
}

class SearchCubitInitial extends SearchCubitState {}

class SearchSuccess extends SearchCubitState{
  final List <SearchModel> data;
  SearchSuccess(this.data);
  @override
  List<Object> get props => [data];
}
class SearchDeleteSuccess extends SearchCubitState{
  final List <SearchModel> data;
  SearchDeleteSuccess(this.data);
  @override
  List<Object> get props => [data];
}
class SearchGagal extends SearchCubitState{
  final String error;
  const SearchGagal(this.error);
  @override
  List<Object> get props => [error];
}