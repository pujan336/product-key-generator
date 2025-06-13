import 'dart:async';

import 'package:flutter/material.dart';

class DotLoaderProvider with ChangeNotifier {
  String _dots = '';
  Timer? _timer;

  String get dots => _dots;

  void start() {
    _dots = '';
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 400), (_) {
      _dots = _dots.length < 3 ? '$_dots.' : '';
      notifyListeners();
    });
  }

  void stop() {
    _timer?.cancel();
    _dots = '';
    notifyListeners();
  }

  void disposeTimer() {
    _timer?.cancel();
  }
}
