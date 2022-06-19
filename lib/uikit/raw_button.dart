import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_wet/utils/color_palette/colors.dart';
import 'package:x_wet/utils/font_preset.dart';

class RawButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool isActive;
  const RawButton({Key? key, required this.onTap, required this.label, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context)=>InkWell(
  onTap: onTap,
    child: Container(
      width: 343.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: isActive ? AppColors.aquaBlue : AppColors.gray
      ),
      child: Center(
        child: Text(label,style: AppTypography.bold.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 22.w,
        ),),
      ),
    ),
  );
}
