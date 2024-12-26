import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/utils/services/form_validation_service.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../domain/entities/auth/register_request.dart';
import '../../../../widgets/input_fields/custom_password_field.dart';
import '../../../../widgets/responsive_text.dart';
import '../../bloc/password_visibility/password_visibility_cubit.dart';
import '../bloc/signup_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.formValidationService});

  final FormValidationService formValidationService;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String? emailError, passwordError, firstNameError, lastNameError;

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
                  .validateFirstName(firstNameController.text);
              if (error != firstNameError) {
                setState(() {
                  firstNameError = error;
                });
              }
            },
            controller: firstNameController,
            decoration: InputDecoration(
              hintText: AppStrings.firstName,
              errorText: firstNameError,
            ),
          ),
          TextField(
            onChanged: (value) {
              final error = widget.formValidationService
                  .validateLastName(lastNameController.text);
              if (error != lastNameError) {
                setState(() {
                  lastNameError = error;
                });
              }
            },
            controller: lastNameController,
            decoration: InputDecoration(
              hintText: AppStrings.lastName,
              errorText: lastNameError,
            ),
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
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, signUpState) {
              if (signUpState is SignupLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (validate()) {
                      final registerRequest = RegisterRequest(
                        email: emailController.text,
                        password: passwordController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                      );
                      context.read<SignupCubit>().signUp(registerRequest);
                    }
                  },
                  child: const ResponsiveText(
                    AppStrings.signUp,
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
    final firstNameError = widget.formValidationService
        .validateFirstName(firstNameController.text);
    final lastNameError =
        widget.formValidationService.validateLastName(lastNameController.text);

    setState(() {
      this.emailError = emailError;
      this.passwordError = passwordError;
      this.firstNameError = firstNameError;
      this.lastNameError = lastNameError;
    });
    return emailError == null &&
        passwordError == null &&
        firstNameError == null &&
        lastNameError == null;
  }
}
