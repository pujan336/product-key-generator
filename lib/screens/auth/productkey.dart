// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import '../../provider/auth/upload_provider.dart';
// import 'package:provider/provider.dart';

// class ProductKey extends StatefulWidget {
//   const ProductKey({super.key});

//   @override
//   State<ProductKey> createState() => _GenerateKeyState();
// }

// class _GenerateKeyState extends State<ProductKey> {
//   String? generatedKey;
//   String generateProductKey({int sections = 4, int charsPerSection = 5}) {
//     const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789';
//     Random rnd = Random();
//     return List.generate(sections, (_) {
//       return List.generate(charsPerSection, (_) {
//         return chars[rnd.nextInt(chars.length)];
//       }).join();
//     }).join('-');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(' Product Key Generator')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   generatedKey ?? 'Press generate to create a product key.',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(width: 22),
//                 generatedKey == null
//                     ? SizedBox()
//                     : InkWell(
//                       onTap: () {
//                         Clipboard.setData(ClipboardData(text: generatedKey!));
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Product key is copied.'),
//                             backgroundColor: Colors.purple,
//                           ),
//                         );
//                       },
//                       child: Icon(
//                         Icons.copy,
//                         size: 24.0,
//                         color: const Color.fromARGB(255, 187, 33, 243),
//                       ),
//                     ),
//               ],
//             ),
//             SizedBox(height: 30),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     height: 45,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           generatedKey = generateProductKey();
//                         });
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color.fromARGB(255, 11, 134, 67),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       child: Text(
//                         'Generate',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   Consumer<UploadProvider>(
//                     builder: (context, uploadProvider, _) {
//                       return SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         height: 45,
//                         child: ElevatedButton(
//                           onPressed:
//                               generatedKey == null
//                                   ? null
//                                   : () {
//                                     context.read<UploadProvider>().upload(
//                                       generatedKey!,
//                                       context,
//                                     );
//                                     setState(() {
//                                       generatedKey = null;
//                                     });
//                                   },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFF532D71),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                           child:
//                               uploadProvider.loading
//                                   ? LoadingAnimationWidget.waveDots(
//                                     color: const Color(0xffffffff),
//                                     size: 33,
//                                   )
//                                   : Text('Upload'),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// product_key_screen.dart
import 'package:flutter/material.dart';
import 'package:nutrace_product_key_generator/provider/auth/product_key.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductKey extends StatelessWidget {
  const ProductKey({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UploadKeyProvider>();
    final key = provider.generatedKey;

    return Scaffold(
      appBar: AppBar(title: Text('Product Key Generator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    key ?? 'Press generate to create a product key.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                if (key != null)
                  InkWell(
                    onTap: () => provider.copyKey(context),
                    child: Icon(Icons.copy, color: Colors.purple),
                  ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () => provider.generateKey(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0B8643),
                      ),
                      child: Text(
                        'Generate',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed:
                          key == null || provider.loading
                              ? null
                              : () => provider.uploadKey(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF532D71),
                      ),
                      child:
                          provider.loading
                              ? LoadingAnimationWidget.waveDots(
                                color: Colors.white,
                                size: 33,
                              )
                              : Text(
                                'Upload',
                                style: TextStyle(color: Colors.white),
                              ),
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
