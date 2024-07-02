
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  FirebaseAuth auth= FirebaseAuth.instance;
  UserCredential? user;
  void Register({required String email,required String password,required String name})async{
    emit(AuthLoading());
    try{
     user=await auth.createUserWithEmailAndPassword(email: email, password: password);
     await user!.user!.updateDisplayName(name);
    emit(AuthSuccess());
    }on FirebaseAuthException catch(e){
       emit(AuthFail(e.code));
    }
    catch (e){
      emit(AuthFail(e.toString()));
    }
  }
    void Login({required String email,required String password})async{
    emit(AuthLoading());
    try {
    user = await auth.signInWithEmailAndPassword(email: email, password: password);
    emit(AuthSuccess());
  }
    on FirebaseAuthException catch(e){
       emit(AuthFail(e.code));
    }
    catch (e){
      emit(AuthFail(e.toString()));
    }
  }
}

