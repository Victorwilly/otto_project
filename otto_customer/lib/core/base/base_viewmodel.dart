import 'dart:async';
import 'package:flutter/foundation.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isDisposed = false;
  bool _isInitializeDone = false;

  FutureOr<void>? _initState;

  BaseViewModel() {
    _init();
  }

  FutureOr<void> init();

  void _init() async {
    setLoading = true;
    _initState = init();
    await _initState;
    _isInitializeDone = true;
    setLoading = false;
  }

  void changeStatus() => setLoading = !isLoading;


  void setLoadingState(bool value) {
    setLoading = value;
    // notifyListeners();
  }

  void reloadState() {
    if (!isLoading) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  FutureOr<void>? get initState => _initState;

  bool get isLoading => _isLoading;
  bool get isDisposed => _isDisposed;
  bool get isInitialized => _isInitializeDone;

  set setLoading(bool value) {
    _isLoading = value;
    // scheduleMicrotask(() {
    //   if (!_isDisposed) notifyListeners();
    // });
  }
}
