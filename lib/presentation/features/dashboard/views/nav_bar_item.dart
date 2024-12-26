import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../../widgets/responsive_text.dart';

class NavBarItem extends StatelessWidget {
  final Function() onTap;
  final IconData? icon;
  final String title;
  final String? svgIcon;
  final bool isSelected;
  final bool showNotificationCounter;
  final int notificationCount;

  const NavBarItem(
      {super.key,
      required this.onTap,
      this.icon,
      required this.title,
      this.svgIcon,
      required this.isSelected,
      this.showNotificationCounter = false,
      this.notificationCount = 0});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: SizeConfig.kVerticalMargin / 2),
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        svgIcon!,
                        height: SizeConfig.height * 0.03,
                        width: SizeConfig.height * 0.03,
                        colorFilter: ColorFilter.mode(
                            isSelected
                                ? AppColors.kPrimaryColor
                                : AppColors.kLightGreyColor,
                            BlendMode.srcIn),
                      ),
                      SizedBox(height: SizeConfig.kVerticalMargin / 2),
                      ResponsiveText(
                        title,
                        fontSize: 12,
                        textColor: isSelected
                            ? AppColors.kPrimaryColor
                            : AppColors.kLightGreyColor,
                      ),
                    ],
                  ),
                ),
                if (showNotificationCounter)
                  Positioned(
                    right: (constraints.maxWidth / 4),
                    child: Container(
                      height: SizeConfig.height * 0.025,
                      width: SizeConfig.height * 0.025,
                      padding: EdgeInsets.all(SizeConfig.kHorizontalMargin / 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.kPrimaryColor),
                      child: FittedBox(
                          child: ResponsiveText(
                        '${notificationCount < 10 ? notificationCount : '9+'}',
                        fontSize: 12,
                        textColor: Colors.white,
                      )),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
