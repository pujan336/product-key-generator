// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginProvider extends ChangeNotifier {
//   String _username = '';
//   String _password = '';
//   String? _accessToken;
//   bool _isLoading = false;

//   String? get accessToken => _accessToken;
//   bool get isLoading => _isLoading;

//   void setUsername(String username) {
//     _username = username;
//     notifyListeners();
//   }

//   void setPassword(String password) {
//     _password = password;
//     notifyListeners();
//   }

//   String? validatePassword(String value) {
//     if (_password == 'emilyspass') {
//       return
//     }
//   }

//   void getUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final url = Uri.parse('https://dummyjson.com/auth/me');

//     final response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer ${prefs.getString('token')}',
//       },
//     );
//     print(response.statusCode);

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       print(data);
//     }
//   }

//   Future<void> login() async {
//     _isLoading = true;
//     notifyListeners();

//     final url = Uri.parse('https://dummyjson.com/auth/login');

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json', 'token': "Barear"},
//         body: jsonEncode({'username': _username, 'password': _password}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _accessToken = data['accessToken'] ?? data['token'];
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', _accessToken!);
//         print(_accessToken);
//         if (_accessToken == null) {
//           throw Exception('No access token received');
//         }
//       } else {
//         throw Exception('Login failed: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginProvider extends ChangeNotifier {
//   String _username = '';
//   String _password = '';
//   String? _accessToken;
//   bool _isLoading = false;

//   String? get accessToken => _accessToken;
//   bool get isLoading => _isLoading;

//   void setUsername(String username) {
//     _username = username;
//     notifyListeners();
//   }

//   void setPassword(String password) {
//     _password = password;
//     notifyListeners();
//   }

//   String? validatePassword(String password) {
//     // if (password.isEmpty) return 'Password is required';
//     // if (password.length < 8) return 'Must be at least 8 characters';
//     // if (!RegExp(r'[A-Z]').hasMatch(password)) {
//     //   return 'Must contain an uppercase letter';
//     // }
//     // if (!RegExp(r'[a-z]').hasMatch(password)) {
//     //   return 'Must contain a lowercase letter';
//     // }
//     // if (!RegExp(r'[0-9]').hasMatch(password)) {
//     //   return 'Must contain a number';
//     // }
//     // if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
//     //   return 'Must contain a special character (!@#\$&*~)';
//     // }
//     // return null;
//     // print('enter the name ');
//   }

//   bool validateCredentials(BuildContext context) {
//     if (_username.trim().isEmpty) {
//       _showError(context, 'Username is required');
//       return false;
//     }
//     final passwordError = validatePassword(_password);
//     if (passwordError != null) {
//       _showError(context, passwordError);
//       return false;
//     }
//     return true;
//   }

//   void _showError(BuildContext context, String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//   }

//   Future<void> login(BuildContext context) async {
//     if (!validateCredentials(context)) return;

//     _isLoading = true;
//     notifyListeners();

//     final url = Uri.parse('https://dummyjson.com/auth/login');

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'username': _username, 'password': _password}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _accessToken = data['accessToken'] ?? data['token'];

//         if (_accessToken == null) {
//           throw Exception('No access token received');
//         }

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', _accessToken!);
//       } else {
//         throw Exception('Login failed: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       _showError(context, 'Login error: ${e.toString()}');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> getUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     final url = Uri.parse('https://dummyjson.com/auth/me');

//     if (token == null) {
//       print('No token found');
//       return;
//     }

//     final response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       print('User Data: $data');
//     } else {
//       print('Failed to fetch user data');
//     }
//   }
// }
