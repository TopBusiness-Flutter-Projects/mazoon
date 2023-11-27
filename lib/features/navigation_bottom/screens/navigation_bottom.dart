import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:new_mazoon/features/login/cubit/login_cubit.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../homePage/cubit/home_page_cubit.dart';
import '../../homePage/screens/home_page.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../../notes/screen/noteplan.dart';
import '../../sources_and_references/screens/sources_references_main_screen.dart';
import '../../start_trip/screens/main_start_trip_screen.dart';
import '../widget/menu_screen_widget.dart';

final ZoomDrawerController z = ZoomDrawerController();

class Zoom extends StatefulWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return ZoomDrawer(
      controller: z,
      isRtl: true,
      borderRadius: 25,
      style: DrawerStyle.defaultStyle,
      openCurve: Curves.linearToEaseOut,
      slideWidth: MediaQuery.of(context).size.width * 0.80,
      duration: const Duration(milliseconds: 700),
      angle: 0.0,
      drawerShadowsBackgroundColor: AppColors.primary,
      shadowLayer1Color: AppColors.transparent,
      shadowLayer2Color: AppColors.black.withOpacity(0.1),
      showShadow: true,
      overlayBlur: 0,
      moveMenuScreen: false,
      mainScreenTapClose: true,
      menuScreenOverlayColor: AppColors.primary,
      menuBackgroundColor: AppColors.white,
      mainScreen: const NavigatorBar(),
      menuScreen: MenuScreenWidget(
        closeClick: () => z.close?.call(),
      ),
    );
  }
}

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({Key? key}) : super(key: key);

  // final userDataModel userDataModel;

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _page = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    context.read<HomePageCubit>().getUserData();
    context.read<LoginCubit>().getCommunicationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      key: _scaffoldKey,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 75,
        items: [
          GestureDetector(
            onTap: () {
              z.toggle!.call();
            },
            child: MySvgWidget(
              path: ImageAssets.moreIcon,
              size: _page != 0 ? 25 : 40,
              imageColor:
                  _page != 0 ? AppColors.secondPrimary : AppColors.white,
            ),
          ),
          MySvgWidget(
            path: ImageAssets.studyIcon,
            size: _page != 1 ? 25 : 40,
            imageColor: _page != 1 ? AppColors.secondPrimary : AppColors.white,
          ),
          MySvgWidget(
            path: ImageAssets.homeIcon,
            size: _page != 2 ? 25 : 40,
            imageColor: _page != 2 ? AppColors.secondPrimary : AppColors.white,
          ),
          MySvgWidget(
            path: ImageAssets.noteIcon,
            size: _page != 3 ? 25 : 40,
            imageColor: _page != 3 ? AppColors.secondPrimary : AppColors.white,
          ),
          MySvgWidget(
            path: ImageAssets.videoIcon,
            size: _page != 4 ? 25 : 40,
            imageColor: _page != 4 ? AppColors.secondPrimary : AppColors.white,
          ),
        ],
        color: AppColors.bottomNavigatorColor,
        buttonBackgroundColor: AppColors.secondPrimary,
        backgroundColor: AppColors.transparent,
        animationCurve: Curves.linear,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) {
          return index == 0 ? false : true;
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: SafeArea(
                child: pages(),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: HomePageAppBarWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget pages() {
    if (_page == 0) {
      return StartTripScreen();
    } else if (_page == 1) {
      return SourcesAndReferencesMainScreen();
    } else if (_page == 2) {
      return HomePage();
    } else if (_page == 3) {
      return NotePlan();
    } else {
      return StartTripScreen();
    }
  }

  Widget appbar() {
    if (_page == 0) {
      return Column(
        children: [
          Text(
            'study'.tr(),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'lecture_exam'.tr(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ],
      );
    } else if (_page == 1) {
      return Column(
        children: [
          Text(
            'guide'.tr(),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'sources_references'.tr(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ],
      );
    } else if (_page == 2) {
      return SizedBox();
      // return BlocBuilder<NavigationCubit, NavigationState>(
      //   builder: (context, state) {
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Row(
      //               children: [
      //                 Text(
      //                   'hello'.tr(),
      //                   style: TextStyle(
      //                     fontSize: 18,
      //                     color: AppColors.white,
      //                   ),
      //                 ),
      //                 SizedBox(width: 8),
      //                 Text(
      //                   context.read<NavigationCubit>().userModel != null
      //                       ? context
      //                           .read<NavigationCubit>()
      //                           .userModel!
      //                           .data!
      //                           .name
      //                       : '',
      //                   style: TextStyle(
      //                     fontSize: 22,
      //                     fontWeight: FontWeight.bold,
      //                     color: AppColors.primary,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             InkWell(
      //               onTap: () {
      //                 // setState(() {
      //                 //   //15860B
      //                 //   //00B3DC
      //                 //   Preferences.instance.setPrimaryColor('#00B3DC').then(
      //                 //     (value) {
      //                 //       return AppColors.getPrimaryColor();
      //                 //     },
      //                 //   ).then(
      //                 //     (value) {
      //                 //       _bottomNavigationKey.currentState!.setState(() {
      //                 //         _page = 2;
      //                 //       });
      //                 //     },
      //                 //   );
      //                 // });
      //               },
      //               child: Text(
      //                 monthSeason(),
      //                 style: TextStyle(fontSize: 14),
      //               ),
      //             )
      //           ],
      //         ),
      //         SizedBox(
      //           width: MediaQuery.of(context).size.width,
      //           child: Text(
      //             'home_page'.tr(),
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               color: AppColors.white,
      //               fontSize: 20,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // );
    } else if (_page == 3) {
      return Column(
        children: [
          Text(
            'notification'.tr(),
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'important_notification'.tr(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  String monthSeason() {
    int nowMonth = DateTime.now().month;
    if (nowMonth >= DateTime.august) {
      return '${DateTime.now().year}/${DateTime.now().year + 1}';
    } else {
      return '${DateTime.now().year - 1}/${DateTime.now().year}';
    }
  }
}
