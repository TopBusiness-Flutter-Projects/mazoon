import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:new_mazoon/features/login/cubit/login_cubit.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../core/widgets/banner.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../main.dart';
import '../cubit/home_page_cubit.dart';
import '../widget/final_review_widget.dart';
import '../widget/home_page_start_study_widget.dart';
import '../widget/home_page_video_item_widget.dart';
import '../widget/live_exam_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getToken().then((e) {
      context.read<LoginCubit>().setNotificationToken(notiToken: e);
    });
    context.read<HomePageCubit>().getUserData().then((value) =>
        context.read<HomePageCubit>().getHomePageData(context: context));
    context.read<HomePageCubit>().accessFirstVideoCustom();

    // _checkVersion();
    super.initState();
  }

  // void _checkVersion() async {
  //   final newVersion = NewVersion(
  //     androidId: "com.topbusiness.new_mazoon",
  //     iOSId: 'com.topbusiness.newMazoon',
  //   );
  //   final status = await newVersion.getVersionStatus();
  //   if (status?.canUpdate == true) {
  //     newVersion.showUpdateDialog(
  //       context: context,
  //       versionStatus: status!,
  //       allowDismissal: false,
  //       dialogTitle: "UPDATE",
  //       dialogText:
  //           "Please update the app from ${status.localVersion} to ${status.storeVersion}",
  //     );
  //   }
  // }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
        body: OfflineBuilder(
            child: Text(
              'no_internet'.tr(),
              style: TextStyle(
                fontSize: getSize(context) / 22,
                color: Color.fromARGB(255, 255, 255, 255),
                shadows: [
                  Shadow(
                      blurRadius: 4,
                      color: Color.fromARGB(255, 0, 0, 0),
                      offset: Offset(0, 0))
                ],
              ),
            ),
            connectivityBuilder: (BuildContext context,
                ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                context.read<HomePageCubit>().getHomePageData(context: context);
                return BlocConsumer<HomePageCubit, HomePageState>(
                  listener: (context, state) {
                    if (state is HomePageLoading) {
                      isLoading = true;
                    } else {
                      isLoading = false;
                    }
                  },
                  builder: (context, state) {
                    HomePageCubit cubit = context.read<HomePageCubit>();
                    return isLoading
                        ? ShowLoadingIndicator()
                        : RefreshIndicator(
                            onRefresh: () async {
                              cubit.getHomePageData(context: context);
                            },
                            color: AppColors.white,
                            backgroundColor: AppColors.secondPrimary,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                SizedBox(height: getSize(context) / 3),
                                BannerWidget(sliderData: cubit.sliders),
                                //
                                cubit.liveModel != null
                                    ? LiveExamWarningWidget()
                                    : SizedBox(
                                        height: 30,
                                      ),
                                cubit.videosBasics.isEmpty
                                    ? Container()
                                    : HomePageVideoWidget(
                                        videosBasics: cubit.videosBasics,
                                        title: 'train_yourself'.tr(),
                                      ),
                                cubit.classes.isEmpty
                                    ? Container()
                                    : HomePageStartStudyWidget(
                                        classes: cubit.classes),
                                cubit.videosResources.isEmpty
                                    ? Container()
                                    : FinalReviewWidget(
                                        model: cubit.videosResources,
                                        title: 'all_exams'.tr(),
                                      ),
                              ],
                            ),
                          );
                    // if (state is HomePageLoading) {
                    //   return ShowLoadingIndicator();
                    // }
                    // else if (state is HomePageError) {
                    //   return NoDataWidget(
                    //     onclick: () {
                    //       context.read<HomePageCubit>().getHomePageData();
                    //     },
                    //     title: 'no_data'.tr(),
                    //   );
                    // }
                  },
                );
              } else {
                return NoDataWidget(
                  onclick: () {
                    context
                        .read<HomePageCubit>()
                        .getHomePageData(context: context);
                  },
                  title: 'no_internet'.tr(),
                );
              }
            }),
      ),
    );
  }
}
