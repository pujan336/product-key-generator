import 'package:flutter/material.dart';

class Loadingprovider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> uploadFile() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }
}
