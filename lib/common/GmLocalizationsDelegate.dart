import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_github_client/common/GmLocalizations.dart';

class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations> {
  const GmLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<GmLocalizations> load(Locale locale) {
    if (kDebugMode) {
      print("$locale");
    }
    return SynchronousFuture<GmLocalizations>(
        GmLocalizations(locale.languageCode == "zh"));
  }

  @override
  bool shouldReload(GmLocalizationsDelegate old) => false;
}
