import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/routes/route_constants.dart';
import '../../../../../core/utils/services/form_validation_service.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/responsive_text.dart';
import '../bloc/login_cubit.dart';
import 'login_form.dart';

class LoginView extends StatelessWidget {
  final FormValidationService formValidationService;

  const LoginView({super.key, required this.formValidationService});

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
          BlocListener<LoginCubit, LoginState>(
            listener: (context, loginState) {
              if (loginState is LoginSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.dashboard, (_) => false);
              } else if (loginState is LoginFailure) {
                CustomSnackBar.showFailureSnackBar(context, loginState.message);
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
                    LoginForm(
                      formValidationService: formValidationService,
                    ),
                    Row(
                      spacing: SizeConfig.kHorizontalMargin,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.kGreyColor,
                          ),
                        ),
                        const ResponsiveText(AppStrings.noAccount),
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
                        Navigator.pushNamed(context, Routes.signup);
                      },
                      child: const ResponsiveText(
                        AppStrings.signUp,
                        textAlign: TextAlign.center,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
