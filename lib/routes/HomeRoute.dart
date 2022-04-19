import 'package:flutter/material.dart';
import 'package:flutter_github_client/common/Git.dart';
import 'package:flutter_github_client/models/index.dart';
import 'package:flutter_github_client/models/share_models/UserModel.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() {
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> {
  static const loadingTag = "##loading##"; //表尾标记
  final _items = <Repo>[Repo()..name = loadingTag];
  bool hasMore = true; //是否还有数据
  int page = 1; //当前请求的是第几页

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: _buildBody(),
      drawer: MyDrawer(),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      //用户未登录，显示登录按钮
      return Center(
        child: ElevatedButton(
          child: Text(GmLocalizations.of(context).login),
          onPressed: () => Navigator.of(context).pushNamed("login"),
        ),
      );
    } else {
      return ListView.separated(
          itemBuilder: (context, index) {
            //如果到了表尾
            if (_items[index].name == loadingTag) {
              if (hasMore) {
                //获取数据
                _retrieveData();

                return Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "没有更多了",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
            }
          },
          separatorBuilder: (context, index) => const Divider(height: .0),
          itemCount: _items.length);
    }
  }

  void _retrieveData() async {
    var data = await Git(context).getRepos(queryParameters: {
      "page": page,
      "page_size": 20,
    });

    hasMore = data!.isNotEmpty && data.length % 20 == 0;

    setState(() {
      _items.insertAll(_items.length - 1, data);
      page++;
    });
  }
}
