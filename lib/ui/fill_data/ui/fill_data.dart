import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:x_wet/gen/assets.gen.dart';
import 'package:x_wet/models/day/day.dart';
import 'package:x_wet/models/days_month/days_month.dart';
import 'package:x_wet/models/month_data/year_data.dart';
import 'package:x_wet/models/user_data/user.dart';
import 'package:x_wet/ui/fill_data/uikit/gender_block.dart';
import 'package:x_wet/ui/home/ui/home_screen.dart';
import 'package:x_wet/uikit/raw_button.dart';
import 'package:x_wet/utils/font_preset.dart';
import '../../../utils/color_palette/colors.dart';

class FillDataScreen extends StatefulWidget {
  const FillDataScreen({Key? key}) : super(key: key);

  @override
  State<FillDataScreen> createState() => _FillDataScreenState();
}

class _FillDataScreenState extends State<FillDataScreen> {
  final weightData = List.generate(196, (index) => '${index + 25}');
  final heightData = List.generate(96, (index) => '${index + 125}');
  String? sex;
  int age = 23;
  String heightMetric = 'in';
  String weightMetric = 'lb';
  int weight = 120;
  int height = 70;
  int currInd = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> page = [
      GenderBlock(
        labelPart: 'gender',
        body: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () => setState(() => sex = 'male'),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                              color: sex == 'male'
                                  ? AppColors.aquaBlue
                                  : AppColors.white)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRect(
                            child: Image.asset(Assets.images.male.path,
                                filterQuality: FilterQuality.high,
                                width: 155.w),
                          ),
                          Text(
                            'Male',
                            style: AppTypography.regular.copyWith(
                                color: sex == 'male'
                                    ? AppColors.aquaBlue
                                    : AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.w),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () => setState(() => sex = 'female'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                              color: sex == 'female'
                                  ? AppColors.aquaBlue
                                  : AppColors.white)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRect(
                            child: Image.asset(Assets.images.female.path,
                                filterQuality: FilterQuality.high,
                                width: 155.w),
                          ),
                          Text(
                            'Female',
                            style: AppTypography.regular.copyWith(
                                color: sex == 'female'
                                    ? AppColors.aquaBlue
                                    : AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.w),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                'Choose your age',
                style: AppTypography.bold.copyWith(
                  color: AppColors.aquaBlue,
                  fontSize: 30.w,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Container(
                width: 343.w,
                height: 56.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.gray.withOpacity(0.3)),
                clipBehavior: Clip.hardEdge,
                child: Center(
                  child: NumberPicker(
                      minValue: 18,
                      textStyle: AppTypography.regular.copyWith(
                          color: AppColors.gray,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.w),
                      selectedTextStyle: AppTypography.bold.copyWith(
                          color: AppColors.aquaBlue,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.combine([
                            TextDecoration.overline,
                            TextDecoration.underline
                          ],),
                          fontSize: 22.w),
                      itemCount: 9,
                      itemWidth: 32.w,
                      maxValue: 78,
                      axis: Axis.horizontal,
                      value: age,
                      onChanged: (val) => setState(() => age = val)),
                ),
              ),
            ),
          ],
        ),
      ),
      GenderBlock(
        labelPart: 'height',
        body: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () => setState(() {
                      heightMetric = 'in';
                      height = 70;
                    }),
                    child: Container(
                      width: 155.w,
                      height: 56.h,
                      clipBehavior: Clip.hardEdge,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                          color: AppColors.gray.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                              color: heightMetric == 'in'
                                  ? AppColors.aquaBlue
                                  : AppColors.white)),
                      child: Center(
                        child: Text(
                          'in',
                          style: AppTypography.regular.copyWith(
                              color: heightMetric == 'in'
                                  ? AppColors.aquaBlue
                                  : AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.w),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () => setState(() {
                      heightMetric = 'cm';
                      height = 155;
                    }),
                    child: Container(
                      width: 160.w,
                      height: 56.h,
                      clipBehavior: Clip.hardEdge,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                          color: AppColors.gray.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                              color: heightMetric == 'cm'
                                  ? AppColors.aquaBlue
                                  : AppColors.white)),
                      child: Center(
                        child: Text(
                          'cm',
                          style: AppTypography.regular.copyWith(
                              color: heightMetric == 'cm'
                                  ? AppColors.aquaBlue
                                  : AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.w),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            NumberPicker(
                minValue: heightMetric == 'in' ? 50 : 120,
                maxValue: heightMetric == 'in' ? 90 : 220,
                value: height,
                itemWidth: 343.w,
                itemHeight: 55.h,
                selectedTextStyle: AppTypography.bold.copyWith(
                    color: AppColors.aquaBlue,
                    fontSize: 48.w,
                    fontWeight: FontWeight.w700),
                textStyle: AppTypography.bold.copyWith(
                    color: AppColors.gray,
                    fontSize: 36.w,
                    fontWeight: FontWeight.w700),
                onChanged: (val) => setState(() => height = val))
          ],
        ),
      ),
      GenderBlock(
        labelPart: 'weight',
        body: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () => setState(() {
                      weightMetric = 'lb';
                      weight = 120;
                    }),
                    child: Container(
                      width: 155.w,
                      height: 56.h,
                      clipBehavior: Clip.hardEdge,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                          color: AppColors.gray.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                              color: weightMetric == 'lb'
                                  ? AppColors.aquaBlue
                                  : AppColors.white)),
                      child: Center(
                        child: Text(
                          'lb',
                          style: AppTypography.regular.copyWith(
                              color: weightMetric == 'lb'
                                  ? AppColors.aquaBlue
                                  : AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.w),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () => setState(() {
                      weightMetric = 'kg';
                      weight = 65;
                    }),
                    child: Container(
                      width: 160.w,
                      height: 56.h,
                      clipBehavior: Clip.hardEdge,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                          color: AppColors.gray.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                              color: weightMetric == 'kg'
                                  ? AppColors.aquaBlue
                                  : AppColors.white)),
                      child: Center(
                        child: Text(
                          'kg',
                          style: AppTypography.regular.copyWith(
                              color: weightMetric == 'kg'
                                  ? AppColors.aquaBlue
                                  : AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18.w),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            NumberPicker(
                minValue: weightMetric == 'lb' ? 55 : 25,
                maxValue: weightMetric == 'lb' ? 485 : 220,
                value: weight,
                itemWidth: 343.w,
                itemHeight: 55.h,
                selectedTextStyle: AppTypography.bold.copyWith(
                    color: AppColors.aquaBlue,
                    fontSize: 48.w,
                    fontWeight: FontWeight.w700),
                textStyle: AppTypography.bold.copyWith(
                    color: AppColors.gray,
                    fontSize: 36.w,
                    fontWeight: FontWeight.w700),
                onChanged: (val) => setState(() => weight = val))
          ],
        ),
      ),
      GenderBlock(
        label: 'Calculating a suitable plan for you',
        body: Column(
          children: [
            SizedBox(
              height: 180.h,
            ),
            Container(
              width: 135.w,
              height: 135.w,
              child: CircularProgressIndicator(
                color: AppColors.aquaBlue,
                strokeWidth: 8.w,
              ),
            ),
          ],
        ),
        labelPart: '',
      ),
    ];
    if (currInd == 3)
      setData().then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (_) => HomeScreen())));
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: currInd > 0 && currInd != 3
            ? IconButton(
                onPressed: () => setState(() => currInd--),
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.aquaBlue,
                ))
            : null,
        title: Text(
          'Parameter settings',
          style: AppTypography.bold
              .copyWith(color: AppColors.black, fontSize: 22.w),
        ),
        elevation: 0.0,
      ),
      backgroundColor: AppColors.white,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: currInd == 3
            ? Assets.images.logomenu.svg(width: 181.w, height: 64.h)
            : RawButton(
          onTap: () => currInd < page.length - 2
              ? sex != null ? setState(() => currInd++) : null
              : showDialog(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                title: Text(
                  'Check your data',
                ),
                content: Text(
                    'Please make sure all data is filled in correctly'),
                actions: [
                  CupertinoDialogAction(
                    child: Text('Cancel',
                        style: TextStyle(color: Colors.blue)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.blue),
                    ),
                    isDefaultAction: true,
                    onPressed: (){
                      Navigator.pop(context);
                      setState(() => currInd++);
                    },
                  )
                ],
              )),
          label: 'Next',
          isActive: sex != null,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [page[currInd]],
          ),
        ),
      ),
    );
  }

  Future<void> setData() async {
    int dailyVolume = 0;
    if(weightMetric=='kg') {
      dailyVolume=(weight ~/ 9 * 0.25 * 1000).toInt();
    }else {
      dailyVolume=((weight/20).round()*0.25*1000).toInt();
    }
      await Hive.box<UserData>('user').put(
        'user',
        UserData(
          age: age,
          sex: sex,
          weight: weight,
          height: height,
          heightMetric: heightMetric,
          weightMetric: weightMetric,
          dailyVolume: dailyVolume,
        ),
      );
    final yearData = await Hive.box<YearData>('year');
    List<MonthData> list = List.generate(12, (index) => MonthData(
      data: List.generate(
        31,
            (ind) => DayData(
          waterValues: [],
          date: DateTime.utc(
              DateTime.now().year, index+1, ind + 1),
        ),
      ),
    ));
      await yearData.put(
              'year',
              YearData(data: list)
            );
      // final monthData = await Hive.openBox<WaterDaysInMonth>('data');
      // if (monthData.isEmpty == true) {
      //   await monthData.put(
      //     'data',
      //     WaterDaysInMonth(
      //       data: List.generate(
      //         daysPerMonths(),
      //             (index) => WaterDay(
      //           waterValues: [],
      //           date: DateTime.utc(
      //               DateTime.now().year, DateTime.now().month, index + 1),
      //         ),
      //       ),
      //     ),
      //   );
      // }
    }

  int daysPerMonths({int? month}) {
    print(month);
    switch (month) {
      case DateTime.april:
        return 30;
      case DateTime.june:
        return 30;
      case DateTime.november:
        return 30;
      case DateTime.september:
        return 30;
      case DateTime.february:
        return 28;
      default:
        return 31;
    }
  }
}
