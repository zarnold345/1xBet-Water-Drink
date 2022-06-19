import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:x_wet/main.dart';
import 'package:x_wet/models/day/day.dart';
import 'package:x_wet/models/month_data/year_data.dart';
import 'package:x_wet/models/user_data/user.dart';
import 'package:x_wet/ui/home/ui/home_screen.dart';
import 'package:x_wet/uikit/raw_bottomsheet.dart';
import 'package:x_wet/uikit/raw_button.dart';
import 'package:x_wet/utils/color_palette/colors.dart';
import 'package:x_wet/utils/font_preset.dart';

class DescriptionScreen extends StatefulWidget {
  DescriptionScreen({required this.dayWater});
  final DayData dayWater;
  @override
  State<StatefulWidget> createState() {
    return _DescriptionScreenState();
  }
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  int drankMl = 0;
  int waterVal = 0;
  List<String> waterData =
      List.generate(30, (index) => ((index + 1) * 50).toString());
  @override
  void initState() {
    for (int i = 0; i < widget.dayWater.waterValues!.length; i++) {
      drankMl += widget.dayWater.waterValues![i];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    drankMl = 0;
    waterVal = 0;
    for (int i = 0; i < widget.dayWater.waterValues!.length; i++) {
      drankMl += widget.dayWater.waterValues![i];
    }
    print(Hive.box<UserData>('user').values.first.weight);
    print((drankMl/Hive.box<UserData>('user').values.first.dailyVolume!)*270);
    return WillPopScope(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen())),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: AppColors.aquaBlue,
              )),
          title: Text(
            months[widget.dayWater.date!.month - 1] +
                ' ' +
                widget.dayWater.date!.day.toString() +
                ', ' +
                daysPerWeek[widget.dayWater.date!.weekday - 1].toString(),
            style: AppTypography.bold.copyWith(
                color: AppColors.black,
                fontSize: 22.w,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "You've drunk",
                style: AppTypography.bold.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30.w),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h, bottom: 50.h),
                child: Text(
                  "$drankMl ml",
                  style: AppTypography.bold.copyWith(
                      color: colorSelector(),
                      fontWeight: FontWeight.w700,
                      fontSize: 30.w),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 231.w,
                    height: 231.w,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          startAngle: 270,
                          showLabels: false,
                          showAxisLine: false,
                          showTicks: false,
                          endAngle: 270,
                          ranges: [
                            GaugeRange(
                              startValue: 0,
                              endValue: 270,
                              color: AppColors.gray.withOpacity(0.5),
                              startWidth: 20.w,
                              endWidth: 20.w,
                            )
                          ],
                        ),
                        RadialAxis(
                          endAngle: 270,
                            // endAngle: drankMl>=Hive.box<UserData>('user').values.first.dailyVolume! ? 270 : (drankMl/Hive.box<UserData>('user').values.first.dailyVolume!)*270,
                            startAngle: 270,
                            showTicks: false,
                            showAxisLine: false,
                            showLabels: false,
                            maximum: Hive.box<UserData>('user').values.first.dailyVolume!.toDouble(),
                            annotations: [
                              GaugeAnnotation(
                                widget: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${((drankMl/Hive.box<UserData>('user').values.first.dailyVolume!)*100).round()>100 ? 100 : ((drankMl/Hive.box<UserData>('user').values.first.dailyVolume!)*100).round()}' +
                                            '%',
                                        style: AppTypography.bold.copyWith(
                                          color: colorSelector(),
                                          fontSize: 30.w,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        '$drankMl/${Hive.box<UserData>('user').values.first.dailyVolume!} ml',
                                        style: AppTypography.bold.copyWith(
                                          color:
                                              AppColors.gray,
                                          fontSize: 18.w,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            pointers: <GaugePointer>[
                              RangePointer(
                                value: drankMl.toDouble(),
                                // value: (drankMl/Hive.box<UserData>('user').values.first.dailyVolume!)*270,
                                width: 21.w,
                                color: colorSelector(),
                                cornerStyle: drankMl>=Hive.box<UserData>('user').values.first.dailyVolume! ? CornerStyle.bothFlat :CornerStyle.bothCurve,
                              )
                            ]),
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: RawButton(
                  onTap: ()=>(subscribed&&widget.dayWater.date?.isBefore(DateTime.now())==true)||(widget.dayWater.date?.day==DateTime.now().day&&widget.dayWater.date?.month==DateTime.now().month)  ? showModalBottomSheet(
                    isDismissible: true,
                    context: context,
                    builder: (_) => RawBottomSheet(
                        label: 'Water',
                        data: waterData,
                        onSelectedItemChanged: (value) =>
                        waterVal = (value+1) * 50,
                        onOk: () async {
                          if (waterVal == 0) {
                            waterVal = 50;
                          }
                          print('added $waterVal');
                          final box = await Hive.openBox<YearData>('year');
                          final listData = box.values.first;
                          List<int> list = widget.dayWater.waterValues!;
                          print(widget.dayWater.date);
                          list.add(waterVal);
                          //TODO: починить доабвление
                          final DayData newData = DayData(
                              date: widget.dayWater.date, waterValues: list);
                          listData.data![widget.dayWater.date!.month-1].data![widget.dayWater.date!.day-1]=newData;
                          // listData.data![widget.dayWater.date!.month-1].data!.sort((a, b) => a.date!.day.compareTo(b.date!.day));
                          // listData.data![widget.dayWater.date!.month-1].data!.add(newData);
                          // listData.data![widget.dayWater.date!.month-1].data!
                          //     .sort((a, b) => a.date!.day.compareTo(b.date!.day));
                          await box.clear();
                          box.put('year', listData);
                          setState(() {});
                          Navigator.pop(context);
                        }),
                  ) : null,
                  label: 'Drink water',
                  isActive: true,
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }

  List<String> months = [
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
  List<String> daysPerWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

 Color colorSelector(){
   print(widget.dayWater.date);
   print(drankMl<Hive.box<UserData>('user').values.first.dailyVolume!);
   if(drankMl<Hive.box<UserData>('user').values.first.dailyVolume!&&widget.dayWater.date!.day!=DateTime.now().day&&widget.dayWater.date!.month==DateTime.now().month)return AppColors.red;
   return AppColors.aquaBlue;
 }
}
