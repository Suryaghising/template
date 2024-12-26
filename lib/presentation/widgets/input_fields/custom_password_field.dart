import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/size_config.dart';
import '../responsive_text.dart';

class CustomPasswordField extends StatelessWidget {
  const CustomPasswordField(
      {super.key,
      this.controller,
      this.passwordError,
      this.isVisible = false,
      this.onChanged,
      this.onVisibilityTap});

  final String? passwordError;
  final TextEditingController? controller;
  final bool isVisible;
  final Function(String?)? onChanged;
  final Function()? onVisibilityTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: passwordError == null
                      ? AppColors.kSecondaryColor
                      : AppColors.kErrorColor),
              borderRadius: BorderRadius.circular(8)),
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.kHorizontalMargin),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: onChanged,
                  obscureText: !isVisible,
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: AppStrings.password,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.kHorizontalMargin),
              GestureDetector(
                  onTap: onVisibilityTap,
                  child: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off)),
            ],
          ),
        ),
        SizedBox(height: SizeConfig.kVerticalMargin / 4),
        if (passwordError != null)
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.kHorizontalMargin),
            child: ResponsiveText(
              passwordError!,
              textColor: AppColors.kErrorColor,
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
