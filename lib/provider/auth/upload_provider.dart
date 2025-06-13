import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as https;
import '../../screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadProvider extends ChangeNotifier {
  bool loading = false;
  String? _generatedKey;

  String? get generatedKey => _generatedKey;
  void setGeneratedKey() {
    _generatedKey = null;
  }

  bool get load => loading;

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
      final response = await https.post(
        Uri.parse(
          'http://no-mole-api-env.eba-9syzkgbp.us-east-1.elasticbeanstalk.com/api/productkey/upload',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'key': key}),
      );
      if (!context.mounted) return;
      if (response.statusCode == 200) {
        showMessage('Product key is uploaded successfully.', context, true);
        loading = false;
      } else if (response.statusCode == 401) {
        showMessage(
          'Unauthorized.',
          context,
          false,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        showMessage(
          'Product key is uploaded is not successfull.',
          context,
          false,
        );
      }
    } catch (e) {
      loading = false;
    } finally {
      loading = false;
    }
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

  void showMessage(String title, BuildContext context, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success
            ? const Color.fromARGB(255, 181, 65, 244)
            : const Color.fromARGB(255, 238, 35, 12),
        content: Text(title),
      ),
    );
  }
}
