import '../repo/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthRepoImpl implements AuthRepo {
  final supabase.SupabaseClient _auth = supabase.Supabase.instance.client;

  @override
  Future<supabase.User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await _auth.auth.signUp(
        email: email,
        password: password,
      );
      // await userCredential.user!.updateDisplayName(name);
      return userCredential.user!;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<supabase.User> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = _auth.auth.currentSession?.user;
      if (user == null) {
        throw 'User not found after login';
      }
      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    await _auth.auth.signOut();
  }

  String? getCurrentEmail() {
    final session = _auth.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
