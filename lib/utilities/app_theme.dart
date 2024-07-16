import 'package:store/utilities/common_exports.dart';

class AppTheme {
  factory AppTheme() => _singleton;

  static final AppTheme _singleton = AppTheme._internal();

  AppTheme._internal();

  ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        scaffoldBackgroundColor: AppColors.eerieBlack,
        primaryColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.white),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColors.white),
            titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.ulagadiSansRegular,
              color: AppColors.white,
            )),
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.ulagadiSansRegular,
            color: AppColors.white,
          ),
          displayMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.ulagadiSansMedium,
            color: AppColors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: AppFonts.ulagadiSansRegular,
            color: AppColors.white,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            fontFamily: AppFonts.ulagadiSansLight,
            color: AppColors.white,
          ),
        ),
      );
}
