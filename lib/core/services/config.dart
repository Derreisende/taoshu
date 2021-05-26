/// 全局配置
class Config {
  // api接口环境
  static String baseUrl = "http://www.jaysite.top/api";

  /// token
  static String accessToken = "";

  //是否判断网络状态
  static bool retryEnable = true;

  //是否启动dio_log输出
  static bool logPrint = false;

  //是否在手机显示dio Log日志
  static bool dioLogPrint = true;


  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
}
