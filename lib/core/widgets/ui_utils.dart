import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_exam_app/core/widgets/loading_indicator_widget.dart';

class UIUtils {
  static void showLoading(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        content: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.2,
          child: LoadingIndicator(),
        ),
      ),
    ),
  );

static void hideLoading(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
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