import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreErrorHandler {
  static String handleError(dynamic error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return 'You don\'t have permission to perform this action';
        case 'not-found':
          return 'The requested resource was not found';
        case 'already-exists':
          return 'The resource already exists';
        case 'resource-exhausted':
          return 'Resource limit exceeded. Please try again later';
        case 'failed-precondition':
          return 'Operation failed due to a precondition not being met';
        case 'aborted':
          return 'Operation was aborted';
        case 'out-of-range':
          return 'Operation is out of valid range';
        case 'unimplemented':
          return 'Operation is not implemented';
        case 'internal':
          return 'Internal error occurred';
        case 'unavailable':
          return 'Service is currently unavailable';
        case 'data-loss':
          return 'Data loss occurred';
        case 'unauthenticated':
          return 'You must be authenticated to perform this action';
        default:
          return 'An error occurred: ${error.message}';
      }
    } else if (error is Exception) {
      return error.toString();
    } else {
      return 'An unexpected error occurred';
    }
  }
} 