import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../provider/auth/upload_provider.dart';
import 'package:provider/provider.dart';

class ProductKey extends StatefulWidget {
  const ProductKey({super.key});

  @override
  State<ProductKey> createState() => _GenerateKeyState();
}

class _GenerateKeyState extends State<ProductKey> {
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
      appBar: AppBar(
        title: Column(
          children: [
            Container(
              margin: EdgeInsets.all(22),
              child: Text(
                ' Product Key Generator',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF532D71),
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(22),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                              fontSize: 16, color: Colors.black, height: 1.5),
                          children: [
                            TextSpan(
                              text:
                                  'The product key generator allows you to create a unique key by clicking the ',
                            ),
                            TextSpan(
                              text: 'Generate',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ' button. To upload the key, click the ',
                            ),
                            TextSpan(
                              text: 'Upload',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ' button. You can then tap the ',
                            ),
                            TextSpan(
                              text: 'copy icon',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  ' to copy the key and paste it into your mobile device’s Notes or another secure location. This process ensures that your key is safely stored and easily accessible whenever needed.',
                            ),
                          ],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 80,
            ),
            Consumer<UploadProvider>(builder: (context, uploadProvider, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    uploadProvider.generatedKey ??
                        'Press generate to create a product key.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 22),
                  uploadProvider.generatedKey == null
                      ? SizedBox()
                      : IconButton(
                          onPressed: () {
                            uploadProvider.copyKey(context);
                          },
                          icon: Icon(
                            Icons.copy,
                            color: Color(0xFF532D71),
                          ),
                        )
                ],
              );
            }),
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
                        context.read<UploadProvider>().generateKey();
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
                  Consumer<UploadProvider>(
                    builder: (context, uploadProvider, _) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: uploadProvider.generatedKey == null
                              ? null
                              : () {
                                  context.read<UploadProvider>().upload(
                                        uploadProvider.generatedKey!,
                                        context,
                                      );
                                  uploadProvider.setGeneratedKey();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF532D71),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: uploadProvider.loading
                              ? LoadingAnimationWidget.waveDots(
                                  color:
                                      const Color.fromARGB(255, 202, 187, 187),
                                  size: 33,
                                )
                              : Text('Upload'),
                        ),
                      );
                    },
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
