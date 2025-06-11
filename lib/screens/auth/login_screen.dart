import 'package:flutter/material.dart';
import 'package:nutrace_product_key_generator/provider/auth/login_provider.dart';
import 'package:nutrace_product_key_generator/provider/auth/upload_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Login Form',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                Consumer<LoginProvider>(
                  builder: (context, LoginProvider, _) {
                    return TextFormField(
                      controller: passwordController,
                      obscureText: !LoginProvider.isVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            LoginProvider.isVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => LoginProvider.toggleVisibility(),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // ...
                const SizedBox(height: 30),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, _) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          loginProvider.setUsername(usernameController.text);
                          loginProvider.setPassword(passwordController.text);
                          loginProvider.login(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
