import 'dart:io';

import 'package:booksea/init.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:connectivity/connectivity.dart';
import 'package:sp_util/sp_util.dart';

import 'connectivity_request_retrier.dart';
import 'config.dart';
import 'proxy.dart';
import 'retry_interceptor.dart';
import 'cache.dart';
import 'error_interceptor.dart';

class Http {
  //超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  static Http _instance = Http._internal();

  factory Http() => _instance;

  Dio dio;
  CancelToken _cancelToken = new CancelToken();

  Http._internal() {
    if(dio == null) {
// BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions baseoptions = new BaseOptions(
      connectTimeout: CONNECT_TIMEOUT,
      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: RECEIVE_TIMEOUT,
      // http 请求头
      headers: {}
    );

    dio = new Dio(baseoptions);
    // 加内容缓存
      dio.interceptors.add(Global.netCache);
    // 添加自定义错误拦截器
      dio.interceptors.add(ErrorInterceptor());
    // 添加日志显示
      dio.interceptors.add(DioLogInterceptor());
    if(Config.retryEnable) {
      // 判断网络状态
      dio.interceptors.add(
        RetryOnConnectionChangeInterceptor(
            requestRetrier: DioConnectivityRequestRetrier(
              dio: dio,
              connectivity: Connectivity()
            )
        )
      );
    }
    if(Config.logPrint) {
      // 屏蔽http信息输出,简化log显示
      dio.interceptors.add(LogInterceptor());
    }
    //在调试模式下需要抓包调试,所以使用代理,并禁用HTTPS证书校验
      if(PROXY_ENABLE){
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
          client.findProxy = (uri) {
            return "PROXY $PROXY_IP:$PROXY_PORT";
          };
          //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        };
      }
    }
  }

/// 初始化公共属性
///
/// [baseUrl] 地址前缀
/// [connectTimeout] 连接超时赶时间
/// [receiveTimeout] 接收超时赶时间
/// [interceptors] 基础拦截器
void init({
  String baseUrl,
  int connectTimeout,
  int receiveTimeout,
  List<Interceptor> interceptors
}) {
  dio.options = dio.options.merge(
    baseUrl: baseUrl,
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout
  );
  if(interceptors != null && interceptors.isNotEmpty) {
    dio.interceptors.addAll(interceptors);
  }
 }

 //设置headers
void setHeaders(Map<String, dynamic> map) {
    dio.options.headers.addAll(map);
 }

 //设置token
void setToken(String token) {
  dio.options.headers.addAll({'Authorization':"Bearer"+' '+token});
 }
/*
 * 取消请求
 *
 * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
 * 所以参数可选
 */
void cancelRequests({CancelToken token}) {
   token ?? _cancelToken.cancel("cancelled");
 }
 
 // 读取本地配置
Map<String, dynamic> getAuthorizationHeader() {
   var headers;
   String accessToken = SpUtil.getString('accessToken');
   if(accessToken != null) {
     headers = {"Authorization":'Bearer $accessToken'};
   }
   return headers;
 }

 Future get(
     String path,{
     Map<String, dynamic> params,
     Options options,
     CancelToken cancelToken,
     bool refresh = false,
     bool noCache = !CACHE_ENABLE,
     String cacheKey,
     bool cacheDisk = false,
     }) async {
     Options requestOptions = options ?? Options();
     requestOptions = requestOptions.merge(extra: {
       "refresh": refresh,
       "noCache": noCache,
       "cacheKey": cacheKey,
       "cacheDisk": cacheDisk
     });
     Map<String, dynamic> _authorization = getAuthorizationHeader();
     if(_authorization != null) {
       requestOptions = requestOptions.merge(headers: _authorization);
     }
     Response response;
     response = await dio.get(
        path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken
     );
     return response.data;
 }

 // restful post 操作
  Future post(
      String path, {
      Map<String, dynamic> params,
      data,
      Options options,
      CancelToken cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.post(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  // restful put 操作
  Future put(
      String path, {
        data,
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.put(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful patch 操作
  Future patch(
      String path, {
        data,
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.patch(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful delete 操作
  Future delete(
      String path, {
        data,
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.delete(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(
      String path, {
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.post(path,
        data: FormData.fromMap(params),
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }


// restful download  下载操作
  Future download(
      String path,
      String savePath, {
        Options options,
        CancelToken cancelToken,
        Function onReceiveProgress,
      }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.download(path, savePath,
        onReceiveProgress: (int received, int total) {
          onReceiveProgress(received, total);
        }, options: requestOptions, cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

}

