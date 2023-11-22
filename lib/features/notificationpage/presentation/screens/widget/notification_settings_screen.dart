import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/features/notificationpage/cubit/notification_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/preferences/preferences.dart';
import '../../../../../core/utils/getsize.dart';
import '../../../../../core/widgets/title_with_circle_background_widget.dart';
import '../../../../homePage/widget/home_page_app_bar_widget.dart';

class NotificationSettingsScreen extends StatelessWidget {
  NotificationSettingsScreen({Key? key}) : super(key: key);
  final List<String> titles = ["sound", "vibration", "visibility"];
  final List<String> subtitles = [
    "sound_control",
    "vibration_control",
    "visibility_control"
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        NotificationCubit cubit = context.read<NotificationCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondPrimary,
            toolbarHeight: 0,
          ),
          body: SafeArea(
            // top: false,
            // maintainBottomViewPadding: true,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: getSize(context) * 0.45),
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  titles[index].tr(),
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.gray1),
                                ),
                                Container(
                                  height: 70,
                                  width: 80,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Switch(
                                      value: index == 0
                                          ? Preferences.instance.notiSound
                                          : index == 1
                                              ? Preferences
                                                  .instance.notiVisbrate
                                              : Preferences.instance.notiLight,
                                      onChanged: (value) async {
                                        cubit.changeSwitch(
                                            value, index, context);
                                        Preferences.instance
                                            .getNotiVibrate()
                                            .then((value) {
                                          Preferences.instance.notiVisbrate =
                                              value ?? false;
                                        });
                                        Preferences.instance
                                            .getNotiSound()
                                            .then((value) {
                                          Preferences.instance.notiSound =
                                              value ?? false;
                                        });
                                        Preferences.instance
                                            .getNotiLights()
                                            .then((value) {
                                          Preferences.instance.notiLight =
                                              value ?? false;
                                        });

                                        print(Preferences.instance.notiSound);
                                        print(
                                            Preferences.instance.notiVisbrate);
                                        print(Preferences.instance.notiLight);
                                      },
                                      activeColor: Colors.white,
                                      activeTrackColor: Colors.orange,
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: Colors.grey.shade400,
                                      splashRadius: 50.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              subtitles[index].tr(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.gray9),
                            ),
                            index == titles.length - 1 ? SizedBox() : Divider()
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: HomePageAppBarWidget(
                    isNotification: true,
                  ),
                ),
                Positioned(
                  top: getSize(context) * 0.34,
                  child:
                      TitleWithCircleBackgroundWidget(title: 'notifications'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
