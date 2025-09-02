import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(
    BuildContext context, {
      required String title,
      required String content,
      required String confirmButtonText,
      required String cancelButtonText,
    }) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Theme.of(dialogContext).colorScheme.secondary,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(dialogContext).colorScheme.inversePrimary,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            color: Theme.of(dialogContext).colorScheme.inversePrimary,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              cancelButtonText,
              style: TextStyle(color: Theme.of(dialogContext).colorScheme.primary),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(false); // Return false when cancelled
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.tertiary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              confirmButtonText,
              style: TextStyle(
                color: Theme.of(dialogContext).colorScheme.inversePrimary,
              ),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
            },
          ),
        ],
      );
    },
  );
}
