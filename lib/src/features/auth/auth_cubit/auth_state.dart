part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoadingVerifyPhoneState extends AuthState {}

class SuccessVerifyPhoneState extends AuthState {}

class ErrorVerifyPhoneState extends AuthState {}

class LoadingVerifyOTPState extends AuthState {}

class SuccessVerifyOTPState extends AuthState {}

class ErrorVerifyOTPState extends AuthState {}

class LoadingRegisterState extends AuthState {}

class SuccessRegisterState extends AuthState {}

class ErrorRegisterState extends AuthState {}
