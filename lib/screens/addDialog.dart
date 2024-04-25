import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xamarin/models/picture.dart';
import 'package:xamarin/picturesProvider.dart';

class AddDialog extends StatelessWidget {
  final Function(Picture) addPictureCallBack;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController thumbnailUrlController = TextEditingController();

  AddDialog({super.key, required this.addPictureCallBack});

  @override
  Widget build(BuildContext context) {
    var picturesProvider = Provider.of<PicturesProvider>(context, listen: false);
    int nextId = picturesProvider.pictures.length + 1;

    return AlertDialog(
      title: const Text("Add a picture"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: imageUrlController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Image URL',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: thumbnailUrlController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Thumbnail URL',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newPicture = Picture(
              id: nextId,
              title: titleController.text,
              imageUrl: imageUrlController.text,
              imageThumbnail: thumbnailUrlController.text,
            );
            var picturesProvider =
                Provider.of<PicturesProvider>(context, listen: false);

            bool isAdded = picturesProvider.addPicture(newPicture);
            if (isAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Picture added successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to add picture.'),
                  duration: Duration(seconds: 2),
                ),
              );
            }

            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
