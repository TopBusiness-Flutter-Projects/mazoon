import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/homePage/cubit/home_page_cubit.dart';

import '../../../core/preferences/preferences.dart';

class LiveExamWarningWidget extends StatelessWidget {
  LiveExamWarningWidget({Key? key}) : super(key: key);
  String lan = 'ar';
  @override
  Widget build(BuildContext context) {
    Preferences.instance.getSavedLang().then((value) {
      lan = value;
    });

    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        var cubit = context.read<HomePageCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 15,
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.liveExamBackgroundColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'live_exam'.tr(),
                        style: TextStyle(
                          color: AppColors.orangeThirdPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        lan == 'en'
                            ? cubit.liveModel!.nameEn
                            : cubit.liveModel!.nameAr,
                        style: TextStyle(
                          color: AppColors.blackLite,
                          fontSize: getSize(context) / 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  ImageAssets.liveExamImage,
                  height: 50,
                  width: 60,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
