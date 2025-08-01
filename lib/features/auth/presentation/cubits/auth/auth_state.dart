part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthSuccess extends AuthState {}
final class AuthLoading extends AuthState {}
final class GetCurrentUserFailed extends AuthState {}
final class LogoutSuccess extends AuthState {}
final class RegisterSuccess extends AuthState {}
final class AuthFail extends AuthState {
  final String exception;

  AuthFail(this.exception);
}