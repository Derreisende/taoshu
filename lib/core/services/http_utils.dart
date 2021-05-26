import 'package:dio/dio.dart';

import 'cache.dart';
import 'http.dart';
import 'config.dart';

class HttpUtils {
  static void init({
    int connectTimeout,
    int receiveTimeout,
    List<Interceptor> interceptors
 }){
    Http().init(
      baseUrl:Config.baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      interceptors: interceptors
    );
   }

   static void setHeaders(Map<String, dynamic> map){
    Http().setHeaders(map);
   }

   static void setToken(String token) {
    Http().setToken(token);
   }

  static void cancelRequests({CancelToken token}) {
    Http().cancelRequests(token: token);
  }

  static Future get(
      String path, {
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
        bool refresh = false,
        bool noCache = !CACHE_ENABLE,
        String cacheKey,
        bool cacheDisk = false,
      }) async {
    return await Http().get(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
      refresh: refresh,
      noCache: noCache,
      cacheKey: cacheKey,
    );
  }

  static Future post(
      String path, {
        data,
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    return await Http().post(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future put(
      String path, {
        data,
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    return await Http().put(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future patch(
      String path, {
        data,
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    return await Http().patch(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future delete(
      String path, {
        data,
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    return await Http().delete(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future postForm(
      String path, {
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    return await Http().postForm(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }
  static Future download(
      String path,
      String savePath, {
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
        Function onReceiveProgress,
      }) async {
    return await Http().download(
      path,
      savePath,
      onReceiveProgress: onReceiveProgress,
      options: options,
      cancelToken: cancelToken,
    );
  }
}