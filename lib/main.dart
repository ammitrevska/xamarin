import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xamarin/picturesList.dart';
import 'package:xamarin/picturesProvider.dart';
import 'package:xamarin/screens/addDialog.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PicturesProvider(),
      child: const MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var picturesProvider =
        Provider.of<PicturesProvider>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromRGBO(221, 224, 255, 1),
        padding: const EdgeInsets.only(top: 13),
        child: const PicturesList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddDialog(
                addPictureCallBack: (newPicture) {
                  picturesProvider.addPicture(newPicture);
                },
              );
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }
}
