import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:xamarin/models/picture.dart';

class PicturesProvider extends ChangeNotifier {
  final List<Picture> _fetchedPictures = [];
  final List<Picture> _newlyAddedPictures = [];
  final List<Picture> _pictures = [];

 List<Picture> get fetchedPictures => _fetchedPictures;
  List<Picture> get newlyAddedPictures => _newlyAddedPictures;

  List<Picture> get pictures => _pictures;

  bool addPicture(Picture picture) {
    _pictures.add(picture);
    notifyListeners();
  return _pictures.contains(picture); // Check if the picture is in the list

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

  // bool addNewPicture(Picture picture) {
  //   _newlyAddedPictures.add(picture);
  //   notifyListeners(); // Notify listeners after adding a new picture
  //     return _pictures.contains(picture); // Check if the picture is in the list

  // }

  void removePicture(Picture picture) {
  bool removedFromFetched = _fetchedPictures.remove(picture);
  bool removedFromNewlyAdded = _newlyAddedPictures.remove(picture);
  bool removedFromPictures = _pictures.remove(picture); // Remove from Provider's state

  if (removedFromFetched || removedFromNewlyAdded || removedFromPictures) {
    notifyListeners(); // Notify listeners only if the picture was removed from any list
  }
}


}

