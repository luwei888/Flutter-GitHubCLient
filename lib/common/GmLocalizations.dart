import 'package:flutter/widgets.dart';

class GmLocalizations {
  bool isZh = false;

  GmLocalizations(this.isZh);

  String get yes {
    return isZh ? "确认" : "yes";
  }

  String get cancel {
    return isZh ? "取消" : "cancel";
  }

  String get logoutTip {
    return isZh ? "退出标签" : "logoutTip";
  }

  String get logout  {
    return isZh ? "退出" : "logout";
  }

  //为了使用方便，我们定义一个静态方法
  static GmLocalizations? of(BuildContext context) {
    return Localizations.of<GmLocalizations>(context, GmLocalizations);
  }

  //Locale相关值，title为应用标题
  String get title {
    return isZh ? "Flutter应用" : "Flutter APP";
  }

  //Locale相关值，title为应用标题
  String get login {
    return isZh ? "登录" : "login";
  }

  //Locale相关值，title为应用标题
  String get language {
    return isZh ? "语言" : "language";
  }

  //Locale相关值，title为应用标题
  String get auto {
    return isZh ? "自动" : "auto";
  }

  String get userName {
    return isZh ? "用户名" : "userName";
  }

  String get password {
    return isZh ? "密码" : "password";
  }

  String get userNameRequired {
    return isZh ? "用户名必须" : "userNameRequired";
  }

  String get passwordRequired {
    return isZh ? "密码必须" : "passwordRequired";
  }

  String get theme {
    return isZh ? "主题" : "theme";
  }

  String get noDescription {
    return isZh ? "无法形容" : "noDescription";
  }



}
