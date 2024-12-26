import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/route_constants.dart';
import '../bloc/splash_cubit.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, splashState) {
          if (splashState is UserAuthenticated) {
            Navigator.of(context).pushReplacementNamed(Routes.dashboard);
          } else if (splashState is UserUnauthenticated) {
            Navigator.of(context).pushReplacementNamed(Routes.login);
          }
        },
        child: Container(),
      ),
    );
  }
}
