import 'package:flutter/material.dart';

import '../theming/colors_manager.dart';

abstract class AppDialogs {
  // Show a loading dialog
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const PopScope(
          child: AlertDialog(
            backgroundColor: ColorsManager.white,
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: ColorsManager.black,
                ),
                SizedBox(width: 16),
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
