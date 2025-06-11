import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class UploadProvider extends ChangeNotifier {
  Future<void> uploading() async {
    final url = Uri.parse(
      'http://no-mole-api-env.eba-9syzkgbp.us-east-1.elasticbeanstalk.com/api/productkey/upload',
    );

    try {
      final response = await https.get(url);

      if (response.statusCode == 200) {
        print('Upload successful!');
      } else {
        print('Upload failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Upload error: $e');
    }
  }
}
