import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as https;
import 'package:nutrace_product_key_generator/const/url/base_const.dart';
import '../../screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadProvider extends ChangeNotifier {
  bool loading = false;
  String? _generatedKey;

  String? get generatedKey => _generatedKey;
  void setGeneratedKey() {
    _generatedKey = null;
  }

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

  Future<void> upload(String key, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    try {
      loading = true;
      notifyListeners();

      final response = await https.post(
        Uri.parse(
          '$baseUrl/api/productkey/upload',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'key': key}),
      );

      if (!context.mounted) return;

      if (response.statusCode == 200) {
        showMessage('Product key uploaded successfully.', context, true);
      } else if (response.statusCode == 401) {
        showMessage('Unauthorized.', context, false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        showMessage('Product key upload failed.', context, false);
      }
    } catch (e) {
      showMessage('An error occurred: $e', context, false);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void copyKey(BuildContext context) {
    if (_generatedKey == null) return;
    Clipboard.setData(ClipboardData(text: _generatedKey!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product key is copied.'),
        backgroundColor: Color(0xFF532D71),
      ),
    );
  }

  void showMessage(String title, BuildContext context, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success
            ? Color(0xFF532D71)
            : const Color.fromARGB(255, 238, 35, 12),
        content: Text(title),
      ),
    );
  }
}
