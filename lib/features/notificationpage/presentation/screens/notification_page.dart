import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/custom_button.dart';
import 'package:new_mazoon/features/notificationpage/presentation/screens/widget/notification_details_widget.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/no_data_widget.dart';
import '../../../../../core/widgets/show_loading_indicator.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/title_with_circle_background_widget.dart';
import '../../../homePage/widget/home_page_app_bar_widget.dart';
import '../../cubit/notification_cubit.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final Random random = Random();
  @override
  void initState() {
    context.read<NotificationCubit>().getAllNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // int randomNumber =random.nextInt(3);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondPrimary,
          toolbarHeight: 0,
        ),
        body: SafeArea(
            top: false,
            maintainBottomViewPadding: true,
            child: Stack(children: [
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      NotificationCubit cubit =
                          context.read<NotificationCubit>();
                      if (state is NotificationPageError) {
                        return NoDataWidget(
                          onclick: () => cubit.getAllNotification(),
                          title: 'no_date',
                        );
                      }
                      return state is NotificationPageLoading
                          ? ShowLoadingIndicator()
                          : RefreshIndicator(
                              onRefresh: () async {
                                cubit.getAllNotification();
                              },
                              color: AppColors.primary,
                              backgroundColor: AppColors.secondPrimary,
                              child: cubit.data!.length > 0
                                  ? Column(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: ListView(
                                            children: [
                                              SizedBox(
                                                  height: getSize(context) / 3),
                                              Container(
                                                child:
                                                    TitleWithCircleBackgroundWidget(
                                                  title: 'notifications'.tr(),
                                                  width: double.infinity,
                                                ),
                                              ),
                                              ...List.generate(
                                                  cubit.data != null
                                                      ? cubit.data!.length
                                                      : 0, (index) {
                                                //  randomNumber = random.nextInt(3);
                                                return InkWell(
                                                  onTap: () async {
                                                    ///seen notification
                                                    await cubit
                                                        .notificationUpdate(
                                                            index, context);
                                                    ////navigate
                                                    //   if(cubit.data![index].type=='text'){
                                                    //     ///show pop
                                                    //   }else if(){

                                                    /////
                                                  },
                                                  child:
                                                      NotificationDetailsWidget(
                                                    // index: randomNumber,
                                                    index: index % 3,
                                                    seen:
                                                        cubit.data![index].seen,
                                                    notificationModel: cubit
                                                        .data!
                                                        .elementAt(index),
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 15),
                                          child: CustomButton(
                                            text: "notification_settings".tr(),
                                            color: AppColors.primary,
                                            onClick: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  Routes
                                                      .settingsNotificationScreen);
                                            },
                                            height: getSize(context) / 6.5,
                                            borderRadius: 50,
                                          ),
                                        )
                                      ],
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(ImageAssets.sleepyImage,
                                              width: getSize(context) / 4),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "no_notifications",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ).tr()
                                        ],
                                      ),
                                    ),
                            );
                    },
                  )),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: HomePageAppBarWidget(
                  isNotification: true,
                  isHome: false,
                ),
              ),
            ])));
  }
}
