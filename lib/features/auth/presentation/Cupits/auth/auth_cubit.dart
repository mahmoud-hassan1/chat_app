import 'package:bloc/bloc.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthRepo _authRepo = AuthRepoImpl();
  User? userCredential;

  void register(
      {required String email,
      required String password,
      required String name}) async {
    emit(AuthLoading());
    try {
      userCredential = await _authRepo.register(
        email: email,
        password: password,
        name: name,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFail(e.toString()));
    }
  }

  void login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      userCredential = await _authRepo.login(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFail(e.toString()));
    }
  }
}
