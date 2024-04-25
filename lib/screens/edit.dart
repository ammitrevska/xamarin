import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:xamarin/models/picture.dart';
import 'package:xamarin/picturesProvider.dart';

class EditDialog extends StatefulWidget {
  final Picture picture;
  const EditDialog({super.key, required this.picture});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.picture.title);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Edit Title"),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  String newTitle = _controller.text.trim();
                  if (newTitle.isNotEmpty) {
                    var picturesProvider =
                        Provider.of<PicturesProvider>(context, listen: false);
                    picturesProvider.editPicture(widget.picture, newTitle);
                    picturesProvider.notifyListeners();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Changes saved"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a title"),
                      ),
                    );
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
