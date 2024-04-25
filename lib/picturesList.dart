import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xamarin/models/picture.dart';
import 'package:http/http.dart' as http;
import 'package:xamarin/picturesProvider.dart';
import 'package:xamarin/screens/details.dart';

class PicturesList extends StatefulWidget {
  const PicturesList({
    super.key,
  });

  @override
  State<PicturesList> createState() => _PicturesState();
}

class _PicturesState extends State<PicturesList> {
  List<Picture> pictures = [];

  @override
  void initState() {
    super.initState();
    Provider.of<PicturesProvider>(context, listen: false).fetchPictures();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PicturesProvider>(
      builder: (context, picturesProvider, child) {
        List<Picture> allPictures = [
          ...picturesProvider.newlyAddedPictures,
          ...picturesProvider.fetchedPictures,
        ];
        return ListView.builder(
          itemCount: allPictures.length,
          itemBuilder: (context, index) {
            final picture = allPictures[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Card(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 3,
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 6),
                  child: ListTile(
                    title: Text(picture.title),
                    leading: Image.network(picture.imageThumbnail),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => DetailScreen(
                                picture: picture,
                                onDelete: (deletePicture) {
                                  var provider = Provider.of<PicturesProvider>(
                                      context,
                                      listen: false);
                                  if (provider.pictures.contains(deletePicture)) {
                                    provider.removePicture(deletePicture);
                                  } else {
                                    print(
                                        'Error: Picture not found in PicturesProvider');
                                  }
                                },
                                onEdit: (editedPicture) {
                                  var provider = Provider.of<PicturesProvider>(
                                      context,
                                      listen: false);
                                  if (provider.pictures.contains(editedPicture)) {
                                    // Perform edit operation here
                                  } else {
                                    print(
                                        'Error: Picture not found in PicturesProvider');
                                  }
                                },
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
