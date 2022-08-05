part of 'auth_cubit_cubit.dart';

abstract class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object> get props => [];
}

class AuthCubitInitial extends AuthCubitState {}

class AuthCubitLoading extends AuthCubitState{}

class AuthCubitSuccess extends AuthCubitState{
  final UserModel user;
  const AuthCubitSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}
class AuthCubitGagal extends AuthCubitState{
  final String error;
  const AuthCubitGagal(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

