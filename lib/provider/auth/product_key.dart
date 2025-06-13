// upload_key_provider.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadKeyProvider extends ChangeNotifier {
  String? _generatedKey;
  bool _loading = false;

  String? get generatedKey => _generatedKey;
  bool get loading => _loading;

  void generateKey({int sections = 4, int charsPerSection = 5}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789';
    Random rnd = Random();
    _generatedKey = List.generate(sections, (_) {
      return List.generate(charsPerSection, (_) {
        return chars[rnd.nextInt(chars.length)];
      }).join();
    }).join('-');
    notifyListeners();
  }

  Future<void> uploadKey(BuildContext context) async {
    if (_generatedKey == null) return;

    _loading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2)); // Simulate API call

    _loading = false;
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product key uploaded successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    _generatedKey = null;
    notifyListeners();
  }

  void copyKey(BuildContext context) {
    if (_generatedKey == null) return;
    Clipboard.setData(ClipboardData(text: _generatedKey!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product key is copied.'),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
