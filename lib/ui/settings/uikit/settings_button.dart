import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_wet/utils/color_palette/colors.dart';
import 'package:x_wet/utils/font_preset.dart';

class SettingsButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback? onPressed;

  SettingsButton(
      {Key? key, required this.icon, required this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () => debugPrint('pressed'),
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: double.infinity,
        height: 95.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(label,style: AppTypography.bold.copyWith(
                color: AppColors.black,
                fontSize: 22.w,
                fontWeight: FontWeight.w700
            ),)
          ],
        ),
      ),
    );
  }
}