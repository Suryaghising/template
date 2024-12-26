import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import '../../presentation/features/auth/bloc/password_visibility/password_visibility_cubit.dart';
import '../../presentation/features/auth/login/bloc/login_cubit.dart';
import '../../presentation/features/auth/login/views/login_view.dart';
import '../../presentation/features/auth/signup/bloc/signup_cubit.dart';
import '../../presentation/features/auth/signup/views/signup_view.dart';
import '../../presentation/features/dashboard/bloc/nav_bar_cubit.dart';
import '../../presentation/features/dashboard/views/dashboard_view.dart';
import '../../presentation/features/splash/bloc/splash_cubit.dart';
import '../../presentation/features/splash/views/splash_view.dart';
import '../utils/services/form_validation_service.dart';
import 'route_constants.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (context) =>
                  sl<SplashCubit>()
                    ..checkUserLoggedIn(),
                  child: const SplashView(),
                ));

      case Routes.login:
        return MaterialPageRoute(
            builder: (_) =>
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<LoginCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<PasswordVisibilityCubit>(),
                    ),
                  ],
                  child: LoginView(
                    formValidationService: sl<FormValidationService>(),
                  ),
                ));

      case Routes.signup:
        return MaterialPageRoute(
            builder: (_) =>
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<SignupCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => sl<PasswordVisibilityCubit>(),
                    ),
                  ],
                  child: SignUpView(
                    formValidationService: sl<FormValidationService>(),
                  ),
                ));

      case Routes.dashboard:
        return MaterialPageRoute(
            builder: (_) =>
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => sl<NavBarCubit>(),
                    ),
                  ],
                  child: DashboardView(),
                ));

      default:
        return null;
    }
  }
}
