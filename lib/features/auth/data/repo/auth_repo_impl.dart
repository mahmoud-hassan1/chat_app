import 'package:chat_app/core/user_model.dart';
import 'package:chat_app/features/auth/data/repo/auth_error_messages.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserCredential? user;

  @override
  Future<Either<AuthFailure, void>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user!.user!.updateDisplayName(name);
      final userData = {
        'name': name,
        'email': email,
        'id': user!.user!.uid,
      };
      await firestore.collection('users').doc(user!.user!.uid).set(userData);
      await user!.user!.sendEmailVerification();
      await logout();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(code: e.code));
    } catch (e) {
        return Left(AuthFailure(message: e.toString()));
    }
  }
  @override
  Future<Either<AuthFailure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    
      if (user!.user!.emailVerified) {
        try{
          print('User Data not found333');
          print(user!.user!.uid);
      final userData = await firestore.collection('users').doc(user!.user!.uid).get();
      if (userData.exists) {
        UserModel.fillInstanceWithJson(userData.data()!);
        return const Right(null);
      }
      else{
        print('User Data not found');
        return Left(AuthFailure(message: 'Some thing went wrong User Data not found'));
      }
      } catch (e) {
        print('User Data not found222');
        print(e);
        return Left(AuthFailure(message: 'Some thing went wrong User Data not found'));
      }
      } else {
        await user!.user!.sendEmailVerification();
        return Left(AuthFailure(message: 'Email not verified please check your email for verification link'));
      }
      
    } on FirebaseAuthException catch (e) {
      print(e);
      return Left(AuthFailure(code: e.code));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));  
    }
  }

  @override
  Future<Either<AuthFailure, void>> logout() async {
    try {
      await auth.signOut();
      user = null;
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(code: e.code));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

 

}
