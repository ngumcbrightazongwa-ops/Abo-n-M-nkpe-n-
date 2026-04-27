import 'failure.dart';

class Result<T> {
  final T? data;
  final Failure? failure;

  const Result._({this.data, this.failure});

  bool get isSuccess => failure == null;
  bool get isFailure => failure != null;

  static Result<T> success<T>(T data) => Result<T>._(data: data);
  static Result<T> error<T>(Failure failure) => Result<T>._(failure: failure);
}
