import 'package:rxdart/rxdart.dart';

class AppStore {
  Map<String, StoreDataFormat<dynamic>> _store =
      <String, StoreDataFormat<dynamic>>{};
  final Map<String, dynamic> _syncStore = <String, dynamic>{};

  void setData<T>(String key, T value) {
    if (_store[key] == null) {
      _store[key] = StoreDataFormat<T>(DateTime(0), BehaviorSubject<T>());
    }

    _store[key]!.data!.add(value);
  }

  BehaviorSubject<T> getData<T>(String key) {
    if (_store[key] == null) {
      _store[key] = StoreDataFormat<T>(DateTime(0), BehaviorSubject<T>());
    }

    return _store[key]!.data as BehaviorSubject<T>;
  }

  void resetStore() {
    _store = <String, StoreDataFormat<dynamic>>{};
  }

  DateTime lastDate(String key) {
    if (_store[key] == null) {
      _store[key] =
          StoreDataFormat<dynamic>(DateTime(0), BehaviorSubject<dynamic>());
    }

    return _store[key]!.date;
  }

  void setDate(String id, [DateTime? date]) {
    _store[id]!.date = date ?? DateTime.now();
  }

  void prefetch<T>(String key, Stream<T> stream, [T? defaultValue]) {
    setData(key, defaultValue);

    stream
        .takeWhileInclusive((T element) => element != defaultValue)
        .take(1)
        .listen((T val) {
      setData(key, val);
    });
  }

  void setDataSync<T>(String key, T val) {
    _syncStore[key] = val;
  }

  T getDataSync<T>(String key) {
    return _syncStore[key] as T;
  }
}

class StoreDataFormat<T> {
  StoreDataFormat(
    this.date, [
    this.data,
  ]);

  DateTime date;
  BehaviorSubject<T>? data;
}
