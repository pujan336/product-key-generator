import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class UploadProvider extends ChangeNotifier {
  bool loading = false;

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
      } else {
        showMessage(
          'Product key is uploaded is not successfull.',
          context,
          false,
        );
      }
    } catch (e) {
      loading = false;
    }

    notifyListeners();
  }

  void showMessage(String title, BuildContext context, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            success
                ? const Color.fromARGB(255, 181, 65, 244)
                : const Color.fromARGB(255, 238, 35, 12),
        content: Text(title),
      ),
    );
  }
}
