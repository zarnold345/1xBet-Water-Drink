import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:x_wet/gen/assets.gen.dart';
import 'package:x_wet/main.dart';
import 'package:x_wet/ui/onboarding/ui/onboarding.dart';
import 'package:x_wet/ui/settings/uikit/settings_button.dart';
import 'package:x_wet/utils/color_palette/colors.dart';
import 'package:x_wet/utils/font_preset.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  InAppReview inappreview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.aquaBlue,
            )),
        title: Text(
          'Settings',
          style: AppTypography.bold
              .copyWith(color: AppColors.black, fontSize: 22.w),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 32.h,),
              if(!subscribed)SettingsButton(
                icon: Assets.images.buyPremium.svg(),
                label: 'Buy premium',
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => OnBoardingScreen())),
              ),
              SettingsButton(
                onPressed: openPrivacyPolicy,
                icon: Assets.images.privacyPolicy.svg(),
                label: 'Privacy policy',
              ),
              SettingsButton(
                onPressed: openTermsOfUse,
                icon: Assets.images.termsOfUse.svg(),
                label: 'Terms of use',
              ),
              SettingsButton(
                onPressed: openSupport,
                icon: Assets.images.support.svg(),
                label: 'Support',
              ),
              SettingsButton(
                onPressed: inappreview.requestReview,
                icon: Assets.images.rateApp.svg(),
                label: 'Rate app',
              )
            ],
          ),
        ),
      ),
    );
  }
}