
import 'package:hive/hive.dart';
part 'day.g.dart';

@HiveType(typeId: 7)
class DayData extends HiveObject{
  DayData({this.date,this.waterValues});

  @HiveField(0)
  DateTime? date;
  @HiveField(1)
  List<int>? waterValues=[];

}