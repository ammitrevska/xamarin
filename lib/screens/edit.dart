import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xamarin/models/picture.dart';

class EditImageModal extends StatefulWidget {
  final Picture picture;
  const EditImageModal({super.key, required this.picture});

  @override
  State<EditImageModal> createState() => _EditImageModalState();
}

class _EditImageModalState extends State<EditImageModal> {
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
                    widget.picture.title = newTitle;
                    Navigator.of(context).pop();
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
