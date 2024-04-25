import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:xamarin/models/picture.dart';
import 'package:collection/collection.dart';


class PicturesProvider extends ChangeNotifier {
  final List<Picture> _fetchedPictures = [];
  final List<Picture> _newlyAddedPictures = [];
  final List<Picture> _pictures = [];

  List<Picture> get fetchedPictures => _fetchedPictures;
  List<Picture> get newlyAddedPictures => _newlyAddedPictures;
  List<Picture> get pictures => _pictures;

  bool addPicture(Picture picture) {
    _newlyAddedPictures.add(picture);
    notifyListeners();
    return _newlyAddedPictures.contains(picture); 
  }

  void fetchPictures() async {
    try {
      final response = await http.get(
        Uri.parse('http://jsonplaceholder.typicode.com/photos'),
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Picture> fetchedPictures = jsonData
            .map<Picture>((json) => Picture(
              id: json['id'] ?? 0,
                  title: json['title'] ?? '',
                  imageUrl: json['url'] ?? '',
                  imageThumbnail: json['thumbnailUrl'] ??
                      'https://via.placeholder.com/150/5aba2d',
                ))
            .toList();
        _fetchedPictures.addAll(fetchedPictures);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch pictures');
      }
    } catch (e) {
      print('Error fetching pictures: $e');
    }
  }

  void removePicture(Picture picture) {
    bool removedFromFetched = _fetchedPictures.remove(picture);
    bool removedFromNewlyAdded = _newlyAddedPictures.remove(picture);
    // bool removedFromPictures =
    //     _pictures.remove(picture);

    if (removedFromFetched || removedFromNewlyAdded) {
      notifyListeners();
    }
  }

 void editPicture(Picture picture, String newTitle) {
  if (_fetchedPictures.contains(picture) ||
      _newlyAddedPictures.contains(picture) ||
      _pictures.contains(picture)) {
    picture.updateTitle(newTitle);
    notifyListeners();
  } else {
    print('Picture not found for editing');
  }
}
}
