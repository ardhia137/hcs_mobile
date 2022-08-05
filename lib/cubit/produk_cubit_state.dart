part of 'produk_cubit_cubit.dart';

abstract class ProdukCubitState extends Equatable {
  const ProdukCubitState();

  @override
  List<Object> get props => [];
}

class ProdukCubitInitial extends ProdukCubitState {}
class ProdukCubitLoading extends ProdukCubitState{}

class ProdukCubitSuccess extends ProdukCubitState{
  final List<ProdukModel> produk;
  const ProdukCubitSuccess(this.produk);

  @override
  // TODO: implement props
  List<Object> get props => [produk];
}
class ProdukCubitGagal extends ProdukCubitState{
  final String error;
  const ProdukCubitGagal(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
