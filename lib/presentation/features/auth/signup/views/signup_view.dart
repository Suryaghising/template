import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/services/form_validation_service.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/responsive_text.dart';
import '../bloc/signup_cubit.dart';
import 'signup_form.dart';

class SignUpView extends StatelessWidget {
  final FormValidationService formValidationService;

  const SignUpView({super.key, required this.formValidationService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK519hfbhF9lIgsP7N-m-vXL6lwUQw1jICdQ&s',
            height: SizeConfig.height * 0.35,
            width: SizeConfig.width,
            fit: BoxFit.cover,
          ),
          BlocListener<SignupCubit, SignupState>(
            listener: (context, signUpState) {
              if (signUpState is SignupSuccess) {
                CustomSnackBar.showSuccessSnackBar(
                    context, 'Sign up successful');
              } else if (signUpState is SignupFailure) {
                CustomSnackBar.showFailureSnackBar(
                    context, signUpState.message);
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.height * 0.25),
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.kHorizontalMargin,
                vertical: SizeConfig.kVerticalMargin,
              ),
              height: SizeConfig.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  spacing: SizeConfig.kVerticalMargin,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SignUpForm(formValidationService: formValidationService),
                    Row(
                      spacing: SizeConfig.kHorizontalMargin,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.kGreyColor,
                          ),
                        ),
                        const ResponsiveText(AppStrings.alreadyHaveAnAccount),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.kGreyColor,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const ResponsiveText(
                        AppStrings.login,
                        textAlign: TextAlign.center,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: SizeConfig.kVerticalMargin * 2,
              left: SizeConfig.kHorizontalMargin,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.kWhiteColor,
                  ))),
        ],
      ),
    );
  }
}
