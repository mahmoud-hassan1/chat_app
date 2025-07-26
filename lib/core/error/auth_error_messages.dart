

class AuthFailure {
  String ? code;
  String message;
  AuthFailure({this.code,this.message=''}){
    if(code!=null){
   switch (code) {
      case 'email-already-in-use':
        message= 'Email already in use';
      case 'invalid-email':
        message= 'Invalid email';
      case 'weak-password':
        message= 'Weak password';
      case 'user-not-found':
        message= 'User not found';
      case 'wrong-password':
        message= 'Wrong password';
      case 'user-disabled':
        message= 'User disabled';
      case 'too-many-requests':
        message= 'Too many requests';
      case 'network-request-failed':
        message= 'Network error';
      default:
        message= 'Unknown error';
    }
  }

  }

} 