import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:x_wet/gen/assets.gen.dart';
import 'package:x_wet/main.dart';
import 'package:x_wet/models/day/day.dart';
import 'package:x_wet/models/month_data/year_data.dart';
import 'package:x_wet/models/user_data/user.dart';
import 'package:x_wet/ui/home/uikit/clarification.dart';
import 'package:x_wet/ui/settings/ui/settings_screen.dart';
import 'package:x_wet/uikit/raw_button.dart';
import 'package:x_wet/utils/color_palette/colors.dart';
import 'package:x_wet/utils/font_preset.dart';
import '../../description/ui/description_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  YearData yearData = Hive.box<YearData>('year').values.first;
  int selMonth = DateTime.now().month;
  final userdata = Hive.box<UserData>('user').values.first;

  @override
  Widget build(BuildContext context) {
    print(selMonth);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: AppColors.white,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SettingsScreen())),
                  icon: Assets.images.settings.svg(width: 24.w, height: 24.w))
            ],
            title: Assets.images.logomenu.svg(width: 113.w, height: 40.h),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 25.h),
            child: RawButton(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DescriptionScreen(
                          dayWater: yearData.data![DateTime.now().month - 1]
                              .data![DateTime.now().day - 1]))),
              label:
                  'Daily intake ${Hive.box<UserData>('user').values.first.dailyVolume} ml',
              isActive: true,
            ),
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () =>
                            selMonth > 1 ? setState(() => selMonth--) : null,
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.black,
                          size: 20.w,
                        )),
                    Text(
                      months[selMonth] + ' ' + DateTime.now().year.toString(),
                      style: AppTypography.bold.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 26.w,
                      ),
                    ),
                    IconButton(
                        onPressed: () =>
                            selMonth < 12 ? setState(() => selMonth++) : null,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.black,
                          size: 20.w,
                        ))
                  ],
                ),
                Padding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var el in prefs)
                        Padding(
                          padding:
                              prefs.indexOf(el) == 0 || prefs.indexOf(el) == 6
                                  ? EdgeInsets.only(
                                      right: prefs.indexOf(el) != 0 ? 3.w : 0,
                                      left: prefs.indexOf(el) == 0 ? 0 : 3.w)
                                  : EdgeInsets.symmetric(horizontal: 3.w),
                          child: Text(
                            el,
                            style: AppTypography.regular.copyWith(
                                color: AppColors.black,
                                fontSize: 14.w,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.start,
                    children: [
                      for (int d = 1;
                          d <
                              DateTime.utc(DateTime.now().year, selMonth, 1)
                                  .weekday;
                          d++)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 7.h),
                          child: Container(
                            width: 30.w,
                            height: 34.h,
                          ),
                        ),
                      for (int i = 0; i < daysPerMonths(); i++)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 7.h),
                          child: InkWell(
                            onTap: () => DateTime.utc(
                                            yearData.data![selMonth - 1]
                                                .data![i].date!.year,
                                            yearData.data![selMonth - 1]
                                                .data![i].date!.month,
                                            yearData.data![selMonth - 1]
                                                .data![i].date!.day) ==
                                        DateTime.utc(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day) ||
                                    (
                                        yearData
                                            .data![selMonth - 1].data![i].date!
                                            .isBefore(DateTime.now()))
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DescriptionScreen(
                                        dayWater: yearData
                                            .data![selMonth - 1].data![i],
                                      ),
                                    ),
                                  )
                                : showDialog(
                                    context: context,
                                    builder: (_) => CupertinoAlertDialog(
                                          title: Text("It's an upcoming day"),
                                          content: Text(
                                              "You can't fill in the upcoming days"),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: Text(
                                                'Ok',
                                                style: TextStyle(
                                                    color: Colors.blueAccent),
                                              ),
                                              isDefaultAction: true,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            )
                                          ],
                                        )),
                            child: Container(
                              width: 30.w,
                              height: 31.h,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Assets.images.cup.svg(
                                      color: checkColor(
                                    yearData.data![selMonth - 1].data![i],
                                  )),
                                  Align(alignment: Alignment.center,child: Text(
                                    '${i + 1}',
                                    style: AppTypography.bold.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.w,
                                    ),
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                ClarificationInfo()
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }

  // Color checkColor(DayData day){
  //   Color color = AppColors.gray;
  //   final DateTime now=DateTime.now();
  //   print(day.date!.day);
  //   if(now.day==day.date!.day){
  //     print('123 ${day.date}');
  //     print(now.day==day.date!.day&&day.date!.month==now.month);
  //   }
  //   if(day.date!.day==now.day&&day.date!.month==now.month){
  //     print("PASPFSAPFPSWF");
  //     color= checkWaterDrunk(day) ? AppColors.aquaBlue : AppColors.yellow;
  //   }
  //   return color;
  // }

  Color checkColor(DayData dayWater) {
    if ((dayWater.date!.day) == DateTime.now().day) {
      if (dayWater.waterValues?.isEmpty == false && checkWaterDrunk(dayWater))
        return AppColors.aquaBlue;
      if (dayWater.date!.day == DateTime.now().day &&
          dayWater.date!.month == DateTime.now().month) return AppColors.yellow;
      if (dayWater.waterValues?.isEmpty == true &&
          dayWater.date!.month == DateTime.now().month) return AppColors.red;
    }
    if (dayWater.date?.isBefore(DateTime.now()) == true &&
        dayWater.waterValues?.isEmpty == true) {
      return AppColors.red;
    } else {
      if (dayWater.date?.isAfter(DateTime.now()) == true) return AppColors.gray;
    }
    if (dayWater.date?.isBefore(DateTime.now()) == true &&
        dayWater.waterValues!.isNotEmpty == true) {
      if (checkWaterDrunk(dayWater) == true) {
        return AppColors.aquaBlue;
      } else {
        return AppColors.red;
      }
    }
    return AppColors.gray;
  }

  bool checkWaterDrunk(DayData waterDay) {
    int sum = 0;
    for (var a in waterDay.waterValues!) {
      sum += a;
    }
    return (sum >= userdata.dailyVolume!) ? true : false;
  }

  int daysPerMonths() {
    switch (selMonth) {
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

  List<String> prefs = ['Mn', 'Tu', 'Wd', 'Th', 'Fr', 'Sa', 'Sn'];

  List<String> months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}
