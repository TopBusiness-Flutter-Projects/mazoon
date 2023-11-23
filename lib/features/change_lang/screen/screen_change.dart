import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/preferences/preferences.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/app_strings.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/change_lang/cubit/lang_state.dart';

import '../../../core/utils/restart_app_class.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/lang_cubit.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeLangCubit, ChangelanguageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = context.read<ChangeLangCubit>();
        return Scaffold(
            body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          EasyLocalization.of(context)!
                              .setLocale(Locale('ar', ''));
                          Preferences.instance.savedLang(AppStrings.arabicCode);
                          Preferences.instance.getSavedLang();
                          HotRestartController.performHotRestart(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: getSize(context) / 2.5,
                          height: getSize(context) / 8,
                          decoration: ShapeDecoration(
                            color: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getSize(context) / 88),
                                  child: Text(
                                    'العربية',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: getSize(context) / 22,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getSize(context) / 44),
                                width: getSize(context) / 8,
                                height: getSize(context) / 8,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: OvalBorder(),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: getSize(context) / 32,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: getSize(context) / 22),
                      InkWell(
                        onTap: () {
                          EasyLocalization.of(context)!
                              .setLocale(Locale('en', ''));
                          Preferences.instance
                              .savedLang(AppStrings.englishCode);
                          Preferences.instance.getSavedLang();
                          HotRestartController.performHotRestart(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: getSize(context) / 2.5,
                          height: getSize(context) / 8,
                          decoration: ShapeDecoration(
                            color: AppColors.switchColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: Row(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getSize(context) / 88),
                                  child: Text(
                                    'English',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: getSize(context) / 22,
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getSize(context) / 44),
                                width: getSize(context) / 8,
                                height: getSize(context) / 8,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: OvalBorder(),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: getSize(context) / 32,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: HomePageAppBarWidget(isHome: false),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
