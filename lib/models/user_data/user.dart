
import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class UserData extends HiveObject{
  UserData({this.age,this.sex,this.height,this.weight,this.weightMetric,this.heightMetric,this.dailyVolume});
  @HiveField(0)
  String? sex='';
  @HiveField(1)
  int? age=0;
  @HiveField(2)
  int? height=0;
  @HiveField(3)
  int? weight=0;
  @HiveField(4)
  String? weightMetric='lb';
  @HiveField(5)
  String? heightMetric='in';
  @HiveField(6)
  int? dailyVolume = 0;
}