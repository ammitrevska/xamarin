import 'package:flutter/material.dart';
import 'package:xamarin/models/picture.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final Function(Picture) onDelete;
  final Picture picture;

  const DeleteDialog({
    super.key,
    required this.onConfirm,
    required this.onDelete,
    required this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete the picture?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            onDelete(picture);
            Navigator.pop(context);
          },
          child: const Text("Yes"),
        )
      ],
    );
  }
}
