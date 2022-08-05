part of 'register_cubit_cubit.dart';

abstract class RegisterCubitState extends Equatable {
  const RegisterCubitState();

  @override
  List<Object> get props => [];
}

class RegisterCubitInitial extends RegisterCubitState {}

class RegisterCubitLoading extends RegisterCubitState {}

class RegisterCubitSuccess extends RegisterCubitState {
  final bool isSuksess;
  const RegisterCubitSuccess(this.isSuksess);

  @override
  // TODO: implement props
  List<Object> get props => [isSuksess];
}

class RegisterCubitGagal extends RegisterCubitState {
  final String error;
  const RegisterCubitGagal(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

abstract class RequestOtpCubitState extends Equatable {
  const RequestOtpCubitState();

  @override
  List<Object> get props => [];
}

class RequestOtpCubitLoading extends RequestOtpCubitState {}

class RequestOtpCubitInitial extends RequestOtpCubitState {}

class RequestOtpCubitSuccess extends RequestOtpCubitState {
  final UserModel user;
  const RequestOtpCubitSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}
class RequestOtpCubitGagal extends RequestOtpCubitState {
  final String error;
  const RequestOtpCubitGagal(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}


abstract class CompleteAuthCubitState extends Equatable {
  const CompleteAuthCubitState();

  @override
  List<Object> get props => [];
}

class CompleteAuthCubitLoading extends CompleteAuthCubitState {}

class CompleteAuthCubitInitial extends CompleteAuthCubitState {}

class CompleteAuthCubitSuccess extends CompleteAuthCubitState {
  final bool isSuksess;
  const CompleteAuthCubitSuccess(this.isSuksess);

  @override
  // TODO: implement props
  List<Object> get props => [isSuksess];
}

class CompleteAuthCubitGagal extends CompleteAuthCubitState {
  final String error;
  const CompleteAuthCubitGagal(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
