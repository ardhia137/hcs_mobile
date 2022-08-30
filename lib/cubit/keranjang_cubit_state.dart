part of 'keranjang_cubit_cubit.dart';

abstract class KeranjangCubitState extends Equatable {
  const KeranjangCubitState();

  @override
  List<Object> get props => [];
}

class KeranjangCubitInitial extends KeranjangCubitState {}

class KeranjangCubitLoading extends KeranjangCubitState {}

class KeranjangCubitSuccess extends KeranjangCubitState {
  final bool isSuksess;
  const KeranjangCubitSuccess(this.isSuksess);

  @override
  // TODO: implement props
  List<Object> get props => [isSuksess];
}

class GetKeranjangCubitSuccess extends KeranjangCubitState{
  final List<KeranjangModel> keranjang;
  const GetKeranjangCubitSuccess(this.keranjang);

  @override
  // TODO: implement props
  List<Object> get props => [keranjang];
}

// class UpdateKeranjangCubitSuccess extends KeranjangCubitState {
//   final bool isSuksess;
//   const UpdateKeranjangCubitSuccess(this.isSuksess);
//   @override
//   // TODO: implement props
//   List<Object> get props => [isSuksess];
// }

class KeranjangCubitGagal extends KeranjangCubitState {
  final String error;
  const KeranjangCubitGagal(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
