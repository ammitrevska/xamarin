import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:xamarin/main.dart';
import 'package:xamarin/models/picture.dart';
import 'package:xamarin/picturesProvider.dart';
import 'package:xamarin/screens/deleteDialog.dart';
import 'package:xamarin/screens/edit.dart';
import 'package:xamarin/screens/fullScreenPicture.dart';

class DetailScreen extends StatelessWidget {
  final Picture picture;
  final void Function(Picture picture) onDelete;
  final void Function(Picture picture) onEdit;

  const DetailScreen({
    super.key,
    required this.picture,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PicturesProvider>(
      builder: (context, picturesProvider, _) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(221, 224, 255, 1),
          appBar: AppBar(
            title: const Text(
              'Picture Details',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
          ),
          body: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.only(top: 13),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(picture.imageUrl),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Title:',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${picture.title}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditDialog(picture: picture);
                                  },
                                );
                              },
                              icon: const Icon(Icons.mode_edit_outline_rounded),
                              label: const Text("Edit"),
                              heroTag: 'edit',
                            ),
                            const SizedBox(width: 10),
                            FloatingActionButton.extended(
                              onPressed: () async {
                                bool confirmed = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DeleteDialog(
                                      onConfirm: () {},
                                      onDelete: (deletedPicture) {
                                        Provider.of<PicturesProvider>(context,
                                                listen: false)
                                            .removePicture(deletedPicture);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Picture deleted'),
                                          ),
                                        );
                                        onDelete(deletedPicture);
                                        Navigator.pop(context);
                                      },
                                      picture: picture,
                                    );
                                  },
                                );
                              },
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
          ),
        );
      },
    );
  }
}
