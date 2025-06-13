import 'package:flutter/material.dart';
import 'package:nutrace_product_key_generator/provider/auth/product_key.dart';

import 'package:nutrace_product_key_generator/screens/auth/productkey.dart';
import 'provider/auth/loading.dart';
import 'provider/auth/login_provider.dart';
import 'provider/auth/upload_provider.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => UploadProvider()),
        ChangeNotifierProvider(create: (_) => Loadingprovider()),
        ChangeNotifierProvider(create: (_) => UploadKeyProvider()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ProductKey(),
    );
  }
}
