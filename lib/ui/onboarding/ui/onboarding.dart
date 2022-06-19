import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:x_wet/gen/assets.gen.dart';
import 'package:x_wet/main.dart';
import 'package:x_wet/models/user_data/user.dart';
import 'package:x_wet/ui/fill_data/ui/fill_data.dart';
import 'package:x_wet/ui/home/ui/home_screen.dart';
import 'package:x_wet/utils/color_palette/colors.dart';
import 'package:x_wet/utils/font_preset.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnBoardingScreenState();
  }
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Color(0xFF142850),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF142850), Color(0xFF253B6E)]),
                image: DecorationImage(
                  image: AssetImage('assets/images/onboarding.png'),
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                )),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.w, top: 5.h),
                        child: InkWell(
                          onTap: () async {
                            final box = await Hive.openBox<bool>('seen');
                            await box.clear();
                            await box.put('seen', true);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        Hive.box<UserData>('user').isEmpty
                                            ? FillDataScreen()
                                            : HomeScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Icon(
                              Icons.clear,
                              color: AppColors.white,
                              size: 23.h,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Image.asset(
                    Assets.images.onboardinglogo.path,
                    width: 300.w,
                    filterQuality: FilterQuality.high,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get drink reminders',
                              style: AppTypography.bold.copyWith(
                                  fontSize: 30.w, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 25.w,
                        height: 4.h,
                        color: AppColors.aquaBlue,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: Text(
                          'Add notes to every day',
                          style: AppTypography.bold.copyWith(
                              fontSize: 30.w, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        width: 25.w,
                        height: 4.h,
                        color: AppColors.aquaBlue,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Text(
                          'Remove all ADS',
                          style: AppTypography.bold.copyWith(
                              fontSize: 30.w, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: InkWell(
                      onTap: () async {
                        await purchase().then((value) => subscribed = value);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    Hive.box<UserData>('user').isEmpty
                                        ? FillDataScreen()
                                        : HomeScreen()));
                      },
                      child: Container(
                        height: 60.h,
                        width: 327.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: AppColors.aquaBlue),
                        child: Center(
                          child: Text(
                            "Buy premium 0.99\$",
                            style: AppTypography.bold.copyWith(
                                fontWeight: FontWeight.w700, fontSize: 22.w),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 50.w, right: 50.w, top: 18.h, bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => openTermsOfUse(),
                          child: Text(
                            'Terms of use',
                            style: AppTypography.regular.copyWith(
                                fontSize: 15.w, fontWeight: FontWeight.w400),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await restore().then((value) => subscribed = value);
                            Navigator.push(context,MaterialPageRoute(builder: (_)=>Hive.box<UserData>('user').isEmpty
                                ? FillDataScreen()
                                : HomeScreen()));
                          },
                          child: Text(
                            'Restore',
                            style: AppTypography.regular.copyWith(
                                fontSize: 15.w, fontWeight: FontWeight.w400),
                          ),
                        ),
                        InkWell(
                          onTap: () => openPrivacyPolicy(),
                          child: Text(
                            'Privacy Policy',
                            style: AppTypography.regular.copyWith(
                                fontSize: 15.w, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
