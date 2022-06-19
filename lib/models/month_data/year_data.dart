import 'package:hive/hive.dart';
import 'package:x_wet/models/days_month/days_month.dart';

part 'year_data.g.dart';

@HiveType(typeId: 88)
class YearData extends HiveObject{
  YearData({this.data});
  @HiveField(0)
  List<MonthData>? data=[];
}