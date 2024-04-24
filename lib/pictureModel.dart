import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PictureModel extends ChangeNotifier {
  String picTitle;

  PictureModel({
    this.picTitle = "title"
  });

  // String get title => _title;

  void updateTitle({required String newTitle}) async {
    picTitle = newTitle;
    notifyListeners(); // Notify listeners of the change
  }
}
