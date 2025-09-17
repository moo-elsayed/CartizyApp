import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'colors_manager.dart';
import 'font_weight_helper.dart';

abstract class TextStylesManager {

  static TextStyle font14color212121Regular = GoogleFonts.inter(
    fontSize: 14.sp,
    color: ColorsManager.color212121,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font14color212121Bold = GoogleFonts.inter(
    fontSize: 14.sp,
    color: ColorsManager.color212121,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font16WhiteMedium = GoogleFonts.inter(
    fontSize: 16.sp,
    color: ColorsManager.white,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font16color212121Medium = GoogleFonts.inter(
    fontSize: 16.sp,
    color: ColorsManager.color212121,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font18color5C5C5CRegular = GoogleFonts.inter(
    fontSize: 18.sp,
    color: ColorsManager.color5C5C5C,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font18color212121Regular = GoogleFonts.inter(
    fontSize: 18.sp,
    color: ColorsManager.color212121,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font22color212121SemiBold = GoogleFonts.inter(
    fontSize: 22.sp,
    color: ColorsManager.color212121,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle font22color1F1F1FBold = GoogleFonts.inter(
    fontSize: 22.sp,
    color: ColorsManager.color1F1F1F,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font48color212121Medium = GoogleFonts.inter(
    fontSize: 48.sp,
    color: ColorsManager.color212121,
    fontWeight: FontWeightHelper.medium,
  );
}
