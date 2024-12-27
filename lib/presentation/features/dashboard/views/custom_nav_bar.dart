import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_assets.dart';
import '../bloc/nav_bar_cubit.dart';
import 'nav_bar_item.dart';

class CustomNavbar extends StatefulWidget {
  const CustomNavbar({super.key});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  int notificationCount = 0;
  bool showNotificationCounter = false;
  int messageCount = 0;
  bool showMessageCount = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 1,
          blurStyle: BlurStyle.normal,
          offset: const Offset(0, -3),
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: BlocBuilder<NavBarCubit, NavBarState>(
              builder: (context, state) {
                return NavBarItem(
                  svgIcon: Assets.svgImages.home,
                  title: 'Home',
                  isSelected: state.selectedIndex == 0,
                  onTap: () {
                    context.read<NavBarCubit>().changeIndex(0);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<NavBarCubit, NavBarState>(
              builder: (context, state) {
                return NavBarItem(
                  showNotificationCounter: showNotificationCounter,
                  svgIcon: Assets.svgImages.mail,
                  title: 'Message',
                  notificationCount: notificationCount,
                  isSelected: state.selectedIndex == 1,
                  onTap: () {
                    context.read<NavBarCubit>().changeIndex(1);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<NavBarCubit, NavBarState>(
              builder: (context, state) {
                return NavBarItem(
                  notificationCount: messageCount,
                  showNotificationCounter: showMessageCount,
                  svgIcon: Assets.svgImages.stories,
                  title: 'Stories',
                  isSelected: state.selectedIndex == 2,
                  onTap: () {
                    context.read<NavBarCubit>().changeIndex(2);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<NavBarCubit, NavBarState>(
              builder: (context, state) {
                return NavBarItem(
                  svgIcon: Assets.svgImages.more,
                  title: 'Profile',
                  isSelected: state.selectedIndex == 3,
                  onTap: () {
                    context.read<NavBarCubit>().changeIndex(3);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
