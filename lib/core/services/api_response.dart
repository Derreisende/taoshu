import 'app_exceptions.dart';

class ApiResponse<T> implements Exception {
  Status status;  //请求状态
  T data;
  AppException exception;

  //请求成功的构造函数，数据赋值给data
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  //请求出错的构造函数，数据赋值给exception
  ApiResponse.error(this.exception) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $exception \n Data : $data";
  }
}

enum Status {
  COMPLETED,  //请求成功
  ERROR       //请求错误
}