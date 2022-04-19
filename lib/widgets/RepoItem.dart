
import 'package:flutter/cupertino.dart';
import 'package:flutter_github_client/models/index.dart';

class RepoItem extends StatefulWidget{
  // 将`repo.id`作为RepoItem的默认key
  RepoItem(this.repo) : super(key: ValueKey(repo.id));

  final Repo repo;

  @override
  _RepoItemState createState() => _RepoItemState();
}

class _RepoItemState extends State<RepoItem> {


  @override
  Widget build(BuildContext context) {
    var subtitle;



  }
}