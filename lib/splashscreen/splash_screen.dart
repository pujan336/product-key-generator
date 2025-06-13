import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/productkey.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences? prefs = await SharedPreferences.getInstance();
      bool firstTimeOrNot = prefs.getString("token") == null;
      if (!mounted) return;

      if (!firstTimeOrNot) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProductKey()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }

      prefs.setBool("first_time", false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xff532d71)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(height: 10),
              Center(
                child: Image.asset(
                  width: 120,
                  height: 120,
                  "assets/images/logo.png",
                ),
              ),
              SizedBox(height: 10),
              const Text(
                "Product Key Generator",
                style: TextStyle(color: Color(0xffffffff), fontSize: 22),
              ),
              const Spacer(),
              LoadingAnimationWidget.waveDots(
                color: const Color(0xffffffff),
                size: 33,
              ),
              SizedBox(height: 68),
            ],
          ),
        ),
      ),
    );
  }
}
