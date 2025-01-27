import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepo {
  Future<User> register(
      {required String email, required String password, required String name});
  Future<User> login({required String email, required String password});
}
