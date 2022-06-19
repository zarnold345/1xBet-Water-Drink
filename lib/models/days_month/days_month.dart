
import 'package:hive/hive.dart';
import 'package:x_wet/models/day/day.dart';
part 'days_month.g.dart';

@HiveType(typeId: 8)
class MonthData extends HiveObject{
  MonthData({this.data});
  @HiveField(0)
  List<DayData>? data=[];
}