import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/loading_indicator_widget.dart';

class UIUtils {
  static bool _isLoadingShown = false;

  static void showLoading(BuildContext context) {
    if (!_isLoadingShown) {
      _isLoadingShown = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.2,
              child: const LoadingIndicator(),
            ),
          ),
        ),
      ).whenComplete(() => _isLoadingShown = false);
    }
  }

  static void hideLoading(BuildContext context) {
    // Check if we can safely pop a dialog and if loading is currently shown
    if (_isLoadingShown && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      _isLoadingShown = false;
    }
  }

  static void showMessage(
    String message, {
    required Color backGroundColor,
    required Color textColor,
  }) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: backGroundColor,
    textColor: textColor,
  );
}
