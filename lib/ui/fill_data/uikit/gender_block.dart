import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_wet/utils/color_palette/colors.dart';
import 'package:x_wet/utils/font_preset.dart';

class GenderBlock extends StatelessWidget {
  final Widget body;
  final String labelPart;
  final String? label;
  const GenderBlock(
      {Key? key,
      required this.labelPart, required this.body, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 31.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label==null ? 'Choose your $labelPart' : label!,
                  style: AppTypography.bold.copyWith(
                      color: AppColors.aquaBlue,
                      fontSize: 30.w,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            body,
          ],
        ),
      );
}
