// ignore_for_file: unnecessary_null_comparison, unnecessary_null_in_if_null_operators
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service-injector/service_injector.dart';

class StorageService {
  SharedPreferences? _storage;
  final Map<String, BehaviorSubject<String>> _store =
      <String, BehaviorSubject<String>>{};

  Future<void> initStorage() async {
    _storage = await SharedPreferences.getInstance();
    return;
  }

  void _initItem(String key) {
    if (_store[key] == null) {
      _store[key] = BehaviorSubject<String>();
    }

    final String val = getItemSync(key);
    if (val != null) {
      _store[key]?.add(val);
    }
  }

  Future<bool> setItem(String key, String value) {
    _initItem(key);
    _store[key]?.add(value);

    return _storage!.setString(key, value);
  }

  setBoolItem(var key, bool value) {
    return _storage!.setBool(key, value);
  }

  Future<bool> setIntItem(String key, int value) {
    return _storage!.setInt(key, value);
  }

  Future<bool> setList(String key, List<String> data) async {
    return _storage!.setStringList(key, data);
  }

  Future<bool> setItems(Map<String, String> data) async {
    final List<Future<bool>> futures = <Future<bool>>[];

    data.forEach((String key, String value) {
      futures.add(setItem(key, value));
    });

    await Future.wait(futures);
    return true;
  }

  String getItemSync(String key) {
    final String val = (_storage?.getString(key) ?? '');
    return val;
  }

  bool getBoolItemSync(String key) {
    var val = (_storage?.getBool(key) ?? false);
    return val;
  }

  int getIntItemSync(String key) {
    final int val = (_storage?.getInt(key) ?? 0);
    return val;
  }

  BehaviorSubject<String>? getItem(String key) {
    _initItem(key);
    return _store[key];
  }

  List<String>? getListItem(String key) {
    List<String>? listItems = _storage!.getStringList(key);

    return listItems;
  }

  Future<bool> removeItem(String key) {
    _initItem(key);
    _store[key]?.add(null ?? '');
    return _storage!.remove(key);
  }

  Future<bool> removeListItem(String key, String data) {
    final List<String> save = si.storageService.getListItem(key) ?? [];
    save.removeWhere((element) => element == data);
    return _storage!.setStringList(key, save);
  }

  Future<bool> removeItems(List<String> keys) async {
    final List<Future<bool>> futures = <Future<bool>>[];
    for (int a = 0; a < keys.length; a++) {
      futures.add(removeItem(keys.elementAt(a)));
    }
    await Future.wait(futures);
    return true;
  }

  Future reloadLocalState() {
    return _storage!.reload();
  }
}
