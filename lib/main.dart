import 'package:flutter/material.dart';
import 'package:requests_inspector/requests_inspector.dart';

import './injection_container.dart' as di;
import 'core/constants/app_colors.dart';
import 'core/routes/app_router.dart';
import 'core/utils/custom_scroll_behaviour.dart';
import 'core/utils/size_config.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp(router: sl<AppRouter>()));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return RequestsInspector(
      enabled: true,
      child: MaterialApp(
        title: 'News Chat',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kPrimaryColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kPrimaryColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kPrimaryColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            hintStyle: TextStyle(
              fontSize: SizeConfig.getResponsiveFont(14),
              color: AppColors.kGreyColor,
            ),
          ),
          textTheme: const TextTheme().copyWith(
            bodyMedium: TextStyle(
                fontSize: SizeConfig.getResponsiveFont(20),
                color: AppColors.kPrimaryColor,
                fontWeight: FontWeight.w700),
            bodySmall: TextStyle(fontSize: SizeConfig.getResponsiveFont(14)),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: SizeConfig.kVerticalMargin)),
              foregroundColor: const WidgetStatePropertyAll(
                Colors.white,
              ),
              minimumSize: WidgetStatePropertyAll(
                Size(SizeConfig.width, SizeConfig.height * 0.05),
              ),
              alignment: Alignment.center,
              textStyle: WidgetStatePropertyAll(
                TextStyle(
                  fontSize: SizeConfig.getResponsiveFont(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor:
                  const WidgetStatePropertyAll(AppColors.kPrimaryColor),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

          useMaterial3: true,
        ),
        onGenerateRoute: router.generateRoute,
        builder: (context, child) {
          return ScrollConfiguration(
              behavior: CustomScrollBehaviour(), child: child!);
        },

        // home: const LoginView(),
      ),
    );
  }
}
