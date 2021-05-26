import 'package:sp_util/sp_util.dart';

import 'package:booksea/core/services/http_utils.dart';
import 'core/services/net_cache.dart';

class Global {
  static NetCacheInterceptor netCache = NetCacheInterceptor();

  static Future init() async {
    await SpUtil.getInstance();

    //初始化网络请求的相关配置
    HttpUtils.init(
      connectTimeout: 10000,
      receiveTimeout: 10000,
      interceptors: [netCache]
    );
  }
}

// void initServices() async {
//   print('starting services ...');
//   ///这里是你放get_storage、hive、shared_pref初始化的地方。
//   ///或者moor连接，或者其他什么异步的东西。
//   await Get.putAsync(() => DbService().init());
//   await Get.putAsync(SettingsService()).init();
//   print('All services started...');
// }
//
// class DbService extends GetxService {
//   Future<DbService> init() async {
//     print('$runtimeType delays 2 sec');
//     await 2.delay();
//     print('$runtimeType ready!');
//     return this;
//   }
// }
//
// class SettingsService extends GetxService {
//   void init() async {
//     print('$runtimeType delays 1 sec');
//     await 1.delay();
//     print('$runtimeType ready!');
//   }
// }
