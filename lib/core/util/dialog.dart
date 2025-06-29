import 'package:flutter/material.dart';

Future<bool> showCloseConfirmationDialog(BuildContext context) async {
  final shouldPop = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Close the app?'),
        content: const Text('Are you sure you want to close the app?'),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel the back navigation
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(true); // Allow the back navigation and close the app
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
  return shouldPop!;
}
