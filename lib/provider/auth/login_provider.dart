import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/auth/product_key.dart';

class LoginProvider extends ChangeNotifier {
  String _username = '';
  String _password = '';
  String? _accessToken;
  bool _isLoading = false;

  static const String fixedUsername = 'emilys';
  static const String fixedPassword = 'emilyspass';

  String? get accessToken => _accessToken;
  bool get isLoading => _isLoading;

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  String? validateUsername(String username) {
    if (username == fixedUsername) return null;

    if (username.isEmpty) return 'Username cannot be empty';
    if (username.length < 3) {
      return 'Username must be at least 3 characters long';
    }

    return null;
  }

  String? validatePassword(String password) {
    if (password == fixedPassword) return null;

    if (password.isEmpty) return 'Password cannot be empty';
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  Future<void> login(BuildContext context) async {
    final usernameError = validateUsername(_username);
    final passwordError = validatePassword(_password);

    if (usernameError != null || passwordError != null) {
      final error = usernameError ?? passwordError!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' $error.'), backgroundColor: Colors.red),
      );
      return;
    } else {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse(
        'http://no-mole-api-env.eba-9syzkgbp.us-east-1.elasticbeanstalk.com/api/auth/login',
      );

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'username': _username, 'password': _password}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          _accessToken = data['accessToken'] ?? data['token'];
          if (_accessToken == null) {
            throw Exception('No access token received');
          }

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', _accessToken!);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProductKey()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Successful'),
              backgroundColor: const Color.fromARGB(255, 16, 202, 72),
            ),
          );
        } else {
          throw Exception('Login failed');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: const Color.fromARGB(255, 240, 72, 60),
          ),
        );
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
