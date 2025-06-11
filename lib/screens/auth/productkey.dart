import 'dart:math';
import 'package:flutter/material.dart';

class ProductKey extends StatefulWidget {
  const ProductKey({super.key});

  @override
  State<ProductKey> createState() => _GenerateKeyState();
}

class _GenerateKeyState extends State<ProductKey> {
  String? generatedKey;
  String generateProductKey({int sections = 4, int charsPerSection = 5}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789';
    Random rnd = Random();
    return List.generate(sections, (_) {
      return List.generate(charsPerSection, (_) {
        return chars[rnd.nextInt(chars.length)];
      }).join();
    }).join('-');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Product Key Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              generatedKey ?? 'Press generate to create a product key.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          generatedKey = generateProductKey();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 134, 67),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Generate',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: ElevatedButton(
                      onPressed:
                          generatedKey == null
                              ? null
                              : () {
                                print('Confirmed Product Key: $generatedKey');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Product key is generated'),
                                  ),
                                );

                                setState(() {
                                  generatedKey = null;
                                });
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF532D71),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text('Confirm'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
