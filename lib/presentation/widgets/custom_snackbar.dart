import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'responsive_text.dart';

class CustomSnackBar {
  static showSuccessSnackBar(context, String message) {
    final snackbar = SnackBar(
      content: ResponsiveText(
        message,
        textColor: Colors.white,
      ),
      backgroundColor: AppColors.kAccentColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static showFailureSnackBar(context, String message) {
    final snackbar = SnackBar(
      content: ResponsiveText(
        message,
        textColor: Colors.white,
      ),
      backgroundColor: AppColors.kErrorColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
