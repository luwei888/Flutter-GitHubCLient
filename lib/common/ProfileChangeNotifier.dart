import 'package:flutter/material.dart';
import 'package:flutter_github_client/models/profile.dart';
import 'Global.dart';

//基类，持久化保存数据
class ProfileChangeNotifier extends ChangeNotifier {
  Profile get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}