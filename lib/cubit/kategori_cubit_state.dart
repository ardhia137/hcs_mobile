part of 'kategori_cubit_cubit.dart';

abstract class KategoriCubitState extends Equatable {
  const KategoriCubitState();

  @override
  List<Object> get props => [];
}

class KategoriCubitInitial extends KategoriCubitState {}
class KategoriCubitLoading extends KategoriCubitState{}

class KategoriCubitSuccess extends KategoriCubitState{
  final List<KategoriModel> kategori;
  const KategoriCubitSuccess(this.kategori);

  @override
  // TODO: implement props
  List<Object> get props => [kategori];
}

class KategoriCubitGagal extends KategoriCubitState{
  final String error;
  const KategoriCubitGagal(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}