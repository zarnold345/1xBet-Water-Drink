import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_wet/utils/color_palette/colors.dart';
import 'package:x_wet/utils/font_preset.dart';

class RawBottomSheet extends StatelessWidget {
  RawBottomSheet(
      {required this.label,
      required this.data,
      required this.onSelectedItemChanged,
       required this.onOk});

  final String label;
  final List<String> data;
  final void Function(int) onSelectedItemChanged;
  final VoidCallback onOk;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height:210.h,
                    child: CupertinoPicker(
                        itemExtent: 48.h,
                        onSelectedItemChanged: onSelectedItemChanged,
                        selectionOverlay: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Divider(
                                color: AppColors.gray.withOpacity(0.4),
                                thickness: 1.h,
                              ),
                              Spacer(),
                              Divider(
                                color: AppColors.gray.withOpacity(0.4),
                                thickness: 1.h,
                              ),
                            ],
                          ),
                        ),
                        children: [
                          for (var el in data)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(el+' '+labelSelector(el),style: TextStyle(
                                  fontSize: 24.w,
                                ),),
                              ],
                            )
                        ]),
                  ),
                  InkWell(
                    onTap: onOk,
                    child: Container(
                      width: double.infinity,
                      color: AppColors.aquaBlue,
                      height: 50.h,
                      child: Center(
                        child: Text('Add the water drunk',style: AppTypography.bold.copyWith(
                            color: AppColors.white,
                            fontSize: 16.w,
                            fontFamily: 'San Francisco',
                            fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h,)

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  String labelSelector(String el){
    if(el=='200')return 'ml (Glass)';
    if(el=='250')return 'ml (Cup)';
    if(el=='500')return 'ml (Small Bottle)';
    if(el=='1000')return 'ml (Bottle)';
    if(el=='1500')return 'ml (Big Bottle)';
    return 'ml';
  }
}
