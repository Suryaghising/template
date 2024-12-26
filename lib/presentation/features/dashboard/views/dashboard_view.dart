import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/responsive_text.dart';
import '../bloc/nav_bar_cubit.dart';
import 'custom_nav_bar.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final List<Widget> _pages = [
    const Center(
      child: ResponsiveText('Home'),
    ),
    const Center(
      child: ResponsiveText('Messages'),
    ),
    const Center(
      child: ResponsiveText('Stories'),
    ),
    const Center(
      child: ResponsiveText('Profile'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<NavBarCubit, NavBarState>(
                builder: (context, navbarState) {
                  return IndexedStack(
                    index: navbarState.selectedIndex,
                    children: _pages,
                  );
                },
              ),
            ),
            const CustomNavbar(),
          ],
        ),
      ),
    );
  }
}
