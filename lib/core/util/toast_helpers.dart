import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

void showErrorMessage(String message) {
  showSimpleNotification(Text(message), background: Colors.red);
}

void showSuccessMessage({
  required String message,
  void Function()? action,
}) {
  showSimpleNotification(
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(message),
            ],
          ),
          background: Colors.black)
      .dismissed
      .then((value) {
    if (action != null) {
      action.call();
    }
  });
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    {required BuildContext context,
    Color backGroundColor = Colors.black,
    Duration duration = const Duration(seconds: 2),
    required String message}) {
  var snackBar = SnackBar(
    content: Text(message),
    backgroundColor: backGroundColor,
    duration: duration,
  );

  return ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
  );
}
