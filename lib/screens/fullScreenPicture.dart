import 'package:flutter/material.dart';
import 'package:xamarin/models/picture.dart';

class FullScreenPicture extends StatelessWidget {
  final String pictureUrl;

  const FullScreenPicture({super.key, required this.pictureUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image"),
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
