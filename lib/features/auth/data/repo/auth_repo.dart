import 'package:chat_app/features/auth/data/repo/auth_error_messages.dart';
import 'package:dartz/dartz.dart';

// Custom error types for authentication

abstract class AuthRepo {
  Future<Either<AuthFailure, void>> register({
    required String email,
    required String password,
    required String name,
  });
  
  Future<Either<AuthFailure, void>> login({
    required String email,
    required String password,
  });
  
  Future<Either<AuthFailure, void>> logout();
  
}
