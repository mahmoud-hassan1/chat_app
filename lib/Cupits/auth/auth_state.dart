part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthSuccess extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthFail extends AuthState {
  final String exception;

  AuthFail(this.exception);
}