import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_wet/gen/assets.gen.dart';
import 'package:x_wet/utils/color_palette/colors.dart';
import 'package:x_wet/utils/font_preset.dart';

class ClarificationInfo extends StatelessWidget {
  const ClarificationInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Clarification',
                  style: AppTypography.bold.copyWith(
                    color: AppColors.black,
                    fontSize: 26.w,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.cup
                    .svg(width: 15.w, height: 19.h, color: AppColors.gray),
                Text(
                  ' - upcoming day',
                  style: AppTypography.regular.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.w,
                      color: AppColors.black),
                )
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.cup
                    .svg(width: 15.w, height: 19.h, color: AppColors.aquaBlue),
                Text(
                  ' - norm is fulfilled',
                  style: AppTypography.regular.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.w,
                      color: AppColors.black),
                )
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.cup
                    .svg(width: 15.w, height: 19.h, color: AppColors.yellow),
                Text(
                  ' - current day',
                  style: AppTypography.regular.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.w,
                      color: AppColors.black),
                )
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.cup
                    .svg(width: 15.w, height: 19.h, color: AppColors.red),
                Text(
                  " - norm isn't fulfilled",
                  style: AppTypography.regular.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.w,
                      color: AppColors.black),
                )
              ],
            ),
          ],
        ),
      );
}
