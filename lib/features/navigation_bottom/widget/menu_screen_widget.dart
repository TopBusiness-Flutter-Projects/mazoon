import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/login/cubit/login_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/utils/restart_app_class.dart';
import '../../../core/widgets/network_image.dart';

import '../../downloads/screen/downlodsscreen.dart';
import '../../rate_app/cubit/rate_app_cubit.dart';
import '../cubit/navigation_cubit.dart';
import 'list_tile_menu_widget.dart';

class MenuScreenWidget extends StatelessWidget {
  const MenuScreenWidget({Key? key, required this.closeClick})
      : super(key: key);

  final VoidCallback closeClick;

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: lang == 'en' ? Radius.circular(60) : Radius.zero,
        bottomLeft: lang == 'ar' ? Radius.circular(60) : Radius.zero,
      ),
      child: Stack(
        children: [
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              LoginCubit cubit2 = context.read<LoginCubit>();
              return Scaffold(
                backgroundColor: AppColors.primary,
                body: SafeArea(
                  child: Column(
                    children: [
                      BlocBuilder<NavigationCubit, NavigationState>(
                        builder: (context, state) {
                          NavigationCubit cubit =
                              context.read<NavigationCubit>();
                          return state is NavigationGetUserLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: getSize(context) / 44),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.profileScreen);
                                      },
                                      child: ManageNetworkImage(
                                        imageUrl: cubit.userModel!.data!.image,
                                        width: getSize(context) / 5,
                                        height: getSize(context) / 5,
                                        borderRadius: 90,
                                      ),
                                    ),
                                    SizedBox(height: getSize(context) / 44),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: getSize(context) / 22),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: lang == 'ar'
                                                ? Alignment.topRight
                                                : Alignment.topLeft,
                                            padding: EdgeInsets.only(
                                              left: lang == 'ar'
                                                  ? getSize(context) / 5
                                                  : 0,
                                            ),
                                            child: Text(
                                              cubit.userModel!.data!.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize:
                                                      getSize(context) / 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  lang == 'ar'
                                                      ? cubit.userModel!.data!
                                                          .season.nameAr
                                                      : cubit.userModel!.data!
                                                          .season.nameEn,
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize:
                                                          getSize(context) / 32,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  lang == 'ar'
                                                      ? cubit.userModel!.data!
                                                          .term.nameAr
                                                      : cubit.userModel!.data!
                                                          .term.nameEn,
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize:
                                                          getSize(context) / 32,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                      SizedBox(height: getSize(context) / 24),
                      Expanded(
                        child: ListView(
                          children: [
                            MenuListTileWidget(
                              title: 'language'.tr(),
                              iconPath: ImageAssets.languageIcon,
                              onclick: () {
                                // errorGetBar('working_on_it'.tr());
                                Navigator.pushNamed(
                                    context, Routes.changeLanguageScreen);
                              },
                            ),
                            MenuListTileWidget(
                              title: 'profile'.tr(),
                              iconPath: ImageAssets.profileIcon,
                              onclick: () {
                                Navigator.pushNamed(
                                    context, Routes.profileScreen);
                              },
                            ),
                            MenuListTileWidget(
                              title: 'register_paper_exam'.tr(),
                              iconPath: ImageAssets.userEditIcon,
                              onclick: () {
                                context
                                    .read<NavigationCubit>()
                                    .getTimes(context);
                              },
                            ),
                            MenuListTileWidget(
                              title: 'mygards_rate'.tr(),
                              iconPath: ImageAssets.degreeIcon,
                              onclick: () {
                                Navigator.pushNamed(
                                    context, Routes.myGradeAndRating);
                              },
                            ),
                            MenuListTileWidget(
                              title: 'exam_hero'.tr(),
                              iconPath: ImageAssets.cupIcon,
                              onclick: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.examHeroScreenRoute,
                                );
                              },
                            ),
                            MenuListTileWidget(
                              title: 'month_plan'.tr(),
                              iconPath: ImageAssets.calenderIcon,
                              onclick: () {
                                Navigator.pushNamed(
                                    context, Routes.monthplanPageScreenRoute);
                              },
                            ),
                            MenuListTileWidget(
                              title: 'live'.tr(),
                              iconPath: ImageAssets.liveIcon,
                              onclick: () {
                                Navigator.pushNamed(
                                    context, Routes.liveExamScreen);
                                // errorGetBar('working_on_it'.tr());
                              },
                            ),
                            MenuListTileWidget(
                              title: 'time_count'.tr(),
                              iconPath: ImageAssets.suggestIcon,
                              onclick: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.countdownScreenRoute,
                                );
                              },
                            ),
                            MenuListTileWidget(
                              title: 'test_yourself'.tr(),
                              iconPath: ImageAssets.testYourselfIcon,
                              onclick: () {
                                Navigator.pushNamed(
                                    context, Routes.makeYourExamScreen);
                              },
                            ),
                            MenuListTileWidget(
                              title: 'reports'.tr(),
                              iconPath: ImageAssets.reportsIcon,
                              onclick: () {
                                Navigator.pushNamed(
                                    context, Routes.reportsScreen);
                              },
                            ),
                            MenuListTileWidget(
                              title: 'downloads'.tr(),
                              iconPath: ImageAssets.downloadsIcon,
                              onclick: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DownloadedFilesScreen()));
                              },
                            ),
                            MenuListTileWidget(
                              title: 'invite_friends'.tr(),
                              iconPath: ImageAssets.shareIcon,
                              onclick: () {
                                Navigator.pushNamed(
                                    context, Routes.inviteFreiendsScreen);
                              },
                            ),
                            MenuListTileWidget(
                              title: 'suggest'.tr(),
                              iconPath: ImageAssets.yourSuggestIcon,
                              onclick: () {
                                Navigator.pushNamed(
                                    context, Routes.suggestScreen);
                              },
                            ),
                            MenuListTileWidget(
                              title: 'rate_app'.tr(),
                              iconPath: ImageAssets.rateIcon,
                              onclick: () async {
                                await context.read<RateAppCubit>().rateApp(); //
                              },
                            ),
                            MenuListTileWidget(
                              title: 'call_us'.tr(),
                              iconPath: ImageAssets.callUsIcon,
                              onclick: () {
                                openBottomSheet();
                              },
                            ),
                            //logout
                            // MenuListTileWidget(
                            //   title: 'logout'.tr(),
                            //   iconPath: ImageAssets.logoutIcon,
                            //   onclick: () {
                            //     Preferences.instance.clearUserData().then(
                            //           (value) => HotRestartController
                            //               .performHotRestart(context),
                            //         );
                            //   },
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Container(
                                // width: getSize(context) / 12,
                                height: 2,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                color: AppColors.white,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _launchUrl(cubit2
                                          .communicationData!.facebookLink);
                                    },
                                    child: Image.asset(
                                      ImageAssets.facebookImage,
                                      width: getSize(context) / 9,
                                      height: getSize(context) / 9,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchUrl(cubit2
                                          .communicationData!.twitterLink);
                                    },
                                    child: Image.asset(
                                      ImageAssets.twitterImage,
                                      width: getSize(context) / 9,
                                      height: getSize(context) / 9,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchUrl(cubit2
                                          .communicationData!.instagramLink);
                                    },
                                    child: Image.asset(
                                      ImageAssets.instagramImage,
                                      width: getSize(context) / 9,
                                      height: getSize(context) / 9,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchUrl(cubit2
                                          .communicationData!.websiteLink);
                                    },
                                    child: Image.asset(
                                      ImageAssets.websiteImage,
                                      width: getSize(context) / 9,
                                      height: getSize(context) / 9,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchUrl(cubit2
                                          .communicationData!.youtubeLink);
                                    },
                                    child: Image.asset(
                                      ImageAssets.youtubeImage,
                                      width: getSize(context) / 9,
                                      height: getSize(context) / 9,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 7,
            right: lang == 'en' ? -40 : null,
            left: lang == 'ar' ? -40 : null,
            child: Container(
              width: getSize(context) / 2.8,
              height: getSize(context) / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getSize(context) / 8),
                color: AppColors.white,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: closeClick,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Container(
                          width: getSize(context) / 6.2,
                          height: getSize(context) / 6.2,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(getSize(context) / 6.2),
                            color: AppColors.orangeThirdPrimary,
                          ),
                          child: Center(
                            child: Icon(
                              lang == 'ar'
                                  ? Icons.arrow_back
                                  : Icons.arrow_forward,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
