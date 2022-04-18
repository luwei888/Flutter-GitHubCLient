import 'dart:collection' show LinkedHashMap;

import 'package:dio/dio.dart';

import 'Global.dart';

class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().microsecondsSinceEpoch;

  Response response;
  int timeStamp; // 创建缓存时间

  @override
  bool operator ==(Object other) {
    return response.hashCode == other.hashCode;
  }

  //将请求url作为缓存的key
  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  // ignore: prefer_collection_literals
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (Global.profile.cache!.enable) {
      return handler.next(options);
    }
    //refresh标记是否下拉刷新
    bool refresh = options.extra["refresh"] == true;
    if (refresh) {
      if (options.extra["list"] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        // 如果不是列表，则只删除uri相同的缓存
        delete(options.uri.toString());
      }
    }

    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob == null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob!.timeStamp) / 1000 <
            Global.profile.cache!.maxAge) {
          return handler.resolve(ob.response);
        } else {
          cache.remove(key);
        }
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 如果启用缓存，将返回结果保存到缓存
    if (Global.profile.cache!.enable) {
      _saveCache(response);
    }
    handler.next(response);
  }

  _saveCache(Response object) {
    RequestOptions options = object.requestOptions;
    // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      if (cache.length == Global.profile.cache!.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"]?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}
