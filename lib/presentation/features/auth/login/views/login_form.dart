import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/services/form_validation_service.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../widgets/input_fields/custom_password_field.dart';
import '../../../../widgets/responsive_text.dart';
import '../../bloc/password_visibility/password_visibility_cubit.dart';
import '../bloc/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.formValidationService});

  final FormValidationService formValidationService;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? emailError, passwordError;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: SizeConfig.kVerticalMargin,
        children: [
          ResponsiveText(
            AppStrings.login,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextField(
            onChanged: (value) {
              final error = widget.formValidationService
                  .validateEmail(emailController.text);
              if (error != emailError) {
                setState(() {
                  emailError = error;
                });
              }
            },
            controller: emailController,
            decoration: InputDecoration(
              errorText: emailError,
              hintText: AppStrings.email,
            ),
          ),
          BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
            builder: (context, passwordVisibilityState) {
              return CustomPasswordField(
                onVisibilityTap: () {
                  context.read<PasswordVisibilityCubit>().toggleVisibility();
                },
                onChanged: (value) {
                  final error = widget.formValidationService
                      .validatePassword(passwordController.text);
                  if (error != passwordError) {
                    setState(() {
                      passwordError = error;
                    });
                  }
                },
                controller: passwordController,
                passwordError: passwordError,
                isVisible: passwordVisibilityState.isVisible,
              );
            },
          ),
          const ResponsiveText(
            AppStrings.forgotPassword,
            textColor: AppColors.kSecondaryColor,
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, loginState) {
              if (loginState is LoginLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (validate()) {
                      context
                          .read<LoginCubit>()
                          .login(emailController.text, passwordController.text);
                    }
                  },
                  child: const ResponsiveText(
                    AppStrings.login,
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ));
            },
          ),
        ],
      ),
    );
  }

  bool validate() {
    final emailError =
        widget.formValidationService.validateEmail(emailController.text);
    final passwordError =
        widget.formValidationService.validatePassword(passwordController.text);
    setState(() {
      this.emailError = emailError;
      this.passwordError = passwordError;
    });
    return emailError == null && passwordError == null;
  }
}
