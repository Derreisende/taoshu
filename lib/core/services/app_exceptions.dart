import 'package:booksea/ui/pages/main/main_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';

import 'package:sp_util/sp_util.dart';
import 'package:booksea/core/router/app_pages.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'http_utils.dart';

/// 自定义异常
class AppException implements Exception {
  final String _message;
  final int _code;

  AppException([
    this._code,
    this._message,
  ]);

  String toString() {
    return "$_message";
  }

  factory AppException.create(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        {
          return BadRequestException(-1, "请求取消");
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        {
          return BadRequestException(-1, "连接超时");
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        {
          return BadRequestException(-1, "请求超时");
        }
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        {
          return BadRequestException(-1, "响应超时");
        }
        break;
      case DioErrorType.RESPONSE:
        {
          try {
            int errCode = error.response.statusCode;
            String errResStr = error.response.toString();
            Map<String, dynamic> errRes = json.decode(errResStr);
            String errMsg = errRes["msg"];
            switch (errCode) {
              case 400:
                {
                  return BadRequestException(errCode, errMsg);
                }
                break;
              case 401:
                {
                  SpUtil.remove("accessToken");
                  // 设置token
                  HttpUtils.setToken("");
                  Get.toNamed(AppPages.LOGIN);
                  MainController  mainCtl = Get.find();
                  mainCtl.changePageIndex(0);
                  mainCtl.changeTabIndex(0);
                  return UnauthorisedException(errCode, errMsg);
                }
                break;
              case 403:
                {
                  return UnauthorisedException(errCode, "服务器拒绝执行");
                }
                break;
              case 404:
                {
                  return UnauthorisedException(errCode, "无法连接服务器");
                }
                break;
              case 405:
                {
                  return UnauthorisedException(errCode, "请求方法被禁止");
                }
                break;
              case 500:
                {
                  return UnauthorisedException(errCode, "服务器内部错误");
                }
                break;
              case 502:
                {
                  return UnauthorisedException(errCode, "无效的请求");
                }
                break;
              case 503:
                {
                  return UnauthorisedException(errCode, "服务器挂了");
                }
                break;
              case 505:
                {
                  return UnauthorisedException(errCode, "不支持HTTP协议请求");
                }
                break;
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return AppException(errCode, error.response.statusMessage);
                }
            }
          } on Exception catch (_) {
            return AppException(-1, "未知错误");
          }
        }
        break;
      default:
        {
          return AppException(-1, error.message);
        }
    }
  }
}

/// 请求错误
class BadRequestException extends AppException {
  BadRequestException([int code, String message]) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends AppException {
  UnauthorisedException([int code, String message]) : super(code, message);
}

// ///刷新token
// Future<String> refreshtoken() async {
//   String newToken;
//   Dio dio = Http().dio;
//   Dio tokenDio = new Dio(); //创建新Dio实例
//   tokenDio.options = dio.options;
//   tokenDio.interceptors.add(DioLogInterceptor());
//   var val = await tokenDio.get(
//     'api/user/RefreshToken',
//     queryParameters: {"refreshToken": SpUtil.getString('refreshToken')},
//   );
//
//   var responseData = json.decode(val.toString());
//   if (responseData != null) {
//     //获取成功
//     if (responseData['code'] == 1000) {
//       //刷新token成功本地存储
//       newToken = responseData['result']['accessToken'];
//       SpUtil.putString(
//           'accessToken', responseData['result']['accessToken']); //本地缓存token
//       SpUtil.putString(
//           'refreshToken', responseData['result']['refreshToken']); //刷新使用token
//     } else {
//       //退出登录，清除所有缓存
//
//     }
//   } else {
//     //退出登录，清除所有缓存
//   }
//   return newToken;
// }
