class Urls{
  static String headip = "49.65.2.242";
  static String headport = "11802";
  static String urlhead = geturlhead();

  static String geturlhead() {
    return "http://" + headip + ":" + headport + "/";
  }
  ///登录时获取token的接口
  static String token = urlhead + "uaa/oauth/token";
}