// ignore_for_file: unused_catch_clause

import 'dart:convert';
import '../config/app_config.dart';
import '../store/app_store.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class StoreService {
  final AppStore _store = AppStore();

  BehaviorSubject<T> getData$<T>(String id) {
    return _store.getData(id);
  }

  void setData<T>(String id, T val) {
    _store.setData(id, val);
  }

  void reset() {
    _store.resetStore();
  }

  BehaviorSubject<T> getApiData<T>({
    String? id,
    Uri? uri,
    Future<Map<String, String>>? headers,
    T Function(dynamic, [String])? transform,
    bool skipCache = false,
    bool skipStatusCheck = false,
  }) {
    final BehaviorSubject<T> prev = _store.getData(id!);

    headers ??= Future<Map<String, String>>.value(<String, String>{});

    final DateTime ago = DateTime.now().subtract(
      Duration(seconds: AppConfig.storeCacheDebounceSeconds),
    );

    final bool canReq =
        skipCache ? skipCache : ago.isAfter(_store.lastDate(id));

    if (canReq) {
      _store.setDate(id);

      headers.then((Map<String, String> hds) {
        http.get(uri!, headers: hds).then((http.Response res) {
          try {
            final dynamic data = json.decode(res.body);

            if (skipStatusCheck ||
                res.statusCode == 200 ||
                res.statusCode == 201) {
              final T newValue = transform!(data);
              _store.setData(id, newValue);

              prev.add(newValue);
            } else {
              final T newValue = transform!(null, data['message'] ?? '');
              _store.setData(id, newValue);

              prev.add(newValue);
            }
          } on Exception catch (e) {
            final T newValue = transform!(
                null, 'An unhandled error was encountered. Contact support!');
            _store.setData(id, newValue);

            prev.add(newValue);
          }
        }).onError((dynamic error, dynamic stackTrace) {});
      });
    }

    return prev;
  }

  bool exists(String key) {
    return _store.getDataSync<dynamic>(key) != null;
  }

  void setDataSync<T>(String key, T val) {
    _store.setDataSync(key, val);
  }

  T getDataSync<T>(String key) {
    return _store.getDataSync(key);
  }
}
