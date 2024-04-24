import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xamarin/models/picture.dart';
import 'package:xamarin/screens/edit.dart';
import 'package:xamarin/screens/fullScreenPicture.dart';

class DetailScreen extends StatelessWidget {
  final Picture picture;

  const DetailScreen({super.key, required this.picture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenPicture(
                      pictureUrl: picture.imageUrl,
                    ),
                  ),
                );
              },
              child: Image.network(picture.imageUrl),
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              child: Text('Title: ${picture.title}'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditImageModal(picture: picture);
                            },
                          );
                        },
                        icon: const Icon(Icons.mode_edit_outline_rounded),
                        label: const Text("Edit"),
                        heroTag: 'edit',
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton.extended(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_rounded),
                        label: const Text("Delete"),
                        heroTag: 'delete',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
