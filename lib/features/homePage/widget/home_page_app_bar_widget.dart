import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../../core/widgets/painting.dart';
import '../../../config/routes/app_routes.dart';
import '../../lessonExamScreen/cubit/questionlessonexamcubit.dart';
import '../../navigation_bottom/cubit/navigation_cubit.dart';
import '../../notificationpage/presentation/screens/notification_page.dart';
import '../../payment/cubit/paymentcubit.dart';
import '../../sources_and_references/cubit/source_references_cubit.dart';
import '../cubit/home_page_cubit.dart';

class HomePageAppBarWidget extends StatelessWidget {
  const HomePageAppBarWidget(
      {Key? key,
      this.isHome = true,
      this.isSource = false,
      this.isFavourite = false,
      this.isExam = false,
      this.liveExam = false,
      this.isPayment = false,
      this.isNotification = false})
      : super(key: key);
  final bool? isHome;
  final bool? isSource;
  final bool? isFavourite;
  final bool isNotification;
  final bool? isExam;
  final bool? isPayment;
  final bool? liveExam;
  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        var controller = context.read<HomePageCubit>();
        return Stack(
          children: [
            SizedBox(
              height: getSize(context) / 2.4,
              child: CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width,
                  (MediaQuery.of(context).size.width * 0.38676844783715014)
                      .toDouble(),
                ),
                painter: RPSCustomPainter(),
              ),
            ),
            Positioned(
              right: getSize(context) / 22,
              left: getSize(context) / 44,
              child: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  NavigationCubit cubit = context.read<NavigationCubit>();
                  return state is NavigationGetUserLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.profileScreen);
                              },
                              child: ManageNetworkImage(
                                imageUrl: cubit.userModel!.data!.image,
                                width: getSize(context) / 7.8,
                                height: getSize(context) / 7.8,
                                borderRadius: 90,
                              ),
                            ),
                            SizedBox(width: getSize(context) / 44),
                            //info column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: lang == 'ar'
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: Text(
                                      cubit.userModel!.data!.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: getSize(context) / 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: getSize(context) / 100),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang == 'ar'
                                              ? cubit.userModel!.data!.season
                                                  .nameAr
                                              : cubit.userModel!.data!.season
                                                  .nameEn,
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: getSize(context) / 28,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                            height: getSize(context) / 100),
                                        Text(
                                          lang == 'ar'
                                              ? cubit
                                                  .userModel!.data!.term.nameAr
                                              : cubit
                                                  .userModel!.data!.term.nameEn,
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: getSize(context) / 28,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: getSize(context) / 88),
                                    //notification
                                    Visibility(
                                      visible: !isNotification,
                                      child: InkWell(
                                        onTap: () {
                                          // errorGetBar('working_on_it'.tr());
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NotificationScreen()));
                                        },
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: getSize(context) / 10,
                                              width: getSize(context) / 10,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  MySvgWidget(
                                                    path: ImageAssets
                                                        .notificationsIcon,
                                                    size: getSize(context) / 16,
                                                    imageColor: AppColors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            controller.notiCount == 0
                                                ? Container()
                                                : Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Container(
                                                      width:
                                                          getSize(context) / 20,
                                                      height:
                                                          getSize(context) / 20,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(getSize(
                                                                      context) /
                                                                  22),
                                                          color:
                                                              AppColors.white),
                                                      child: Center(
                                                        child: Text(
                                                          controller.notiCount
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: getSize(
                                                                    context) /
                                                                28,
                                                            color: AppColors
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: getSize(context) / 24),
                                    //info
                                    Visibility(
                                      visible: isHome! ||
                                          isNotification ||
                                          isFavourite!,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.elMazoonInfo);
                                        },
                                        child: MySvgWidget(
                                          path: ImageAssets.aboutIcon,
                                          size: getSize(context) / 16,
                                          imageColor: AppColors.white,
                                        ),
                                      ),
                                    ),

                                    Visibility(
                                      visible: isHome! || isNotification,
                                      child: SizedBox(
                                          width: getSize(context) / 24),
                                    ),
                                    //favourite
                                    Visibility(
                                      visible: !isFavourite!,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.favouriteScreen);
                                        },
                                        child: MySvgWidget(
                                          path: ImageAssets.loveIcon,
                                          size: getSize(context) / 16,
                                          imageColor: AppColors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: isHome!
                                            ? getSize(context) / 24
                                            : getSize(context) / 18),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        isPayment!
                                            ? {
                                                context
                                                    .read<PaymentCubit>()
                                                    .calResonse = null,
                                                context
                                                    .read<PaymentCubit>()
                                                    .couponController
                                                    .clear(),
                                                context
                                                    .read<PaymentCubit>()
                                                    .monthes = []
                                              }
                                            : isSource!
                                                ? context
                                                    .read<
                                                        SourceReferencesCubit>()
                                                    .sourcesReferencesByIdList
                                                    .clear()
                                                : isExam!
                                                    ? {
                                                        Navigator.pop(context),
                                                        context
                                                            .read<
                                                                QuestionsLessonExamCubit>()
                                                            .isRecording = false
                                                      }
                                                    : liveExam!
                                                        ? {
                                                            Navigator
                                                                .pushReplacementNamed(
                                                              context,
                                                              Routes
                                                                  .homePageScreenRoute,
                                                            )
                                                          }
                                                        : null;
                                      },
                                      child: Visibility(
                                        visible: !isHome!,
                                        child: Icon(
                                          EasyLocalization.of(context)!
                                                      .currentLocale!
                                                      .languageCode ==
                                                  'ar'
                                              ? Icons.arrow_back_ios_new_sharp
                                              : Icons.arrow_forward_ios,
                                          color: AppColors.white,
                                          size: getSize(context) / 18,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: !isHome!,
                                      child: SizedBox(
                                          width: getSize(context) / 28),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
