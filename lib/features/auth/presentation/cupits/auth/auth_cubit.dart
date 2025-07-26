
import 'package:bloc/bloc.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo_impl.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthRepo authRepo=AuthRepoImpl();
  void register({required String email,required String password,required String name})async{
    emit(AuthLoading());
    final result=await authRepo.register(email: email, password: password, name: name);
    result.fold(
      (failure) => emit(AuthFail(failure.message)),
      (success) => emit(AuthSuccess()),
    );
  }
    void login({required String email,required String password})async{
    emit(AuthLoading());
    final result=await authRepo.login(email: email, password: password);
    result.fold(
      (failure) => emit(AuthFail(failure.message)),
      (success) => emit(AuthSuccess()),
    );
  }
}

