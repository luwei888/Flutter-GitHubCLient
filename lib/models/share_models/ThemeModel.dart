import 'package:flutter/material.dart';
import 'package:flutter_github_client/common/Global.dart';
import 'package:flutter_github_client/common/ProfileChangeNotifier.dart';

class ThemeModel extends ProfileChangeNotifier {
  //获取当前主题，如果为设置主题，则默认使用蓝色主题
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == profile.theme, orElse: () => Colors.blue);

  set theme(ColorSwatch colorSwatch) {
    if(colorSwatch != theme){
      profile.theme = colorSwatch[500]!.value;
      notifyListeners();
    }
  }
}
