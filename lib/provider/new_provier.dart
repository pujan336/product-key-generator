// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../model/models.dart';

// class UserProvider with ChangeNotifier {
//   User? _user;
//   bool _isLoading = false;

//   User? get user => _user;
//   bool get isLoading => _isLoading;

//   Future<void> fetchRandomUser() async {
//     _isLoading = true;
//     notifyListeners();

//     final url = Uri.parse('https://randomuser.me/api/?gender=female');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         _user = User.fromJson(data['results'][0]);

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('saved_email', _user!.email);
//         print("Random visited email: ${_user!.email} san");
//       }
//     } catch (e) {
//       print("Error fetching user: $e");
//     }
//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<String?> getSavedEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('saved_email');
//   }
// }
