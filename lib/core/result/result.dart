class Result<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  const Result._({this.data, this.error, required this.isSuccess});

  factory Result.success(T data) {
    return Result._(data: data, isSuccess: true);
  }

  factory Result.failure(String error) {
    return Result._(error: error, isSuccess: false);
  }

  bool get isError => !isSuccess;

  T get value {
    if (isSuccess && data != null) {
      return data!;
    }
    throw Exception('Cannot get value from error result');
  }

  String get errorMessage {
    if (isError && error != null) {
      return error!;
    }
    throw Exception('Cannot get error from success result');
  }

  void when({
    required Function(T data) success,
    required Function(String error) failure,
  }) {
    if (isSuccess) {
      success(data!);
    } else {
      failure(error!);
    }
  }
} 