import 'package:flutter/material.dart';
import 'package:xamarin/models/picture.dart';

class FullScreenPicture extends StatelessWidget {
  final String pictureUrl;

  const FullScreenPicture({super.key, required this.pictureUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 224, 255, 1),
      appBar: AppBar(
        title: const Text(
          "Image",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Image.network(
            pictureUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
