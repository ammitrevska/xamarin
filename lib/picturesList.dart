import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:xamarin/models/picture.dart';
import 'package:http/http.dart' as http;
import 'package:xamarin/screens/details.dart';

class PicturesList extends StatefulWidget {
  const PicturesList({super.key});

  @override
  State<PicturesList> createState() => _PicturesState();
}

class _PicturesState extends State<PicturesList> {
  List<Picture> pictures = [];

  @override
  void initState() {
    super.initState();
    fetchPictures();
  }

  Future<void> fetchPictures() async {
    try {
      final response = await http.get(
        Uri.parse('http://jsonplaceholder.typicode.com/photos'),
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        //for each json object we create picture obj
        List<Picture> fetchedPictures = jsonData
            .map<Picture>((json) => Picture(
                  title: json['title'] ?? '',
                  imageUrl: json['url'] ?? '',
                  imageThumbnail: json['thumbnailUrl'] ??
                      'https://via.placeholder.com/150/5aba2d',
                ))
            .toList();
        setState(() {
          pictures = fetchedPictures;
        });
      } else {
        throw Exception('Failed to fetch pictures');
      }
    } catch (e) {
      print('Error fetching pictures: $e');
    }
  }

//   void deletePicture(Picture picture) {
//   setState(() {
//     pictures.remove(picture);
//   });
// }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pictures.length,
      itemBuilder: (context, index) {
        final picture = pictures[index];
        return Card.outlined(
          margin: const EdgeInsets.only(
            top: 5,
            bottom: 3,
          ),
          color: Colors.transparent,
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
                          setState(() {
                            pictures.remove(deletePicture);
                          });
                        })),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
