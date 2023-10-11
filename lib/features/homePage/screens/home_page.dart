import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../../../core/widgets/banner.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
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
  bool isLoading = true;
  @override
  void initState() {
    context.read<HomePageCubit>().getUserData().then(
          (value) => context.read<HomePageCubit>().getHomePageData(),
        );
    // context.read<HomePageCubit>().openFirstClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
          child: Text(
            'no_internet'.tr(),
            style: TextStyle(
              fontSize: 22,
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
              context.read<HomePageCubit>().getHomePageData();

              return BlocBuilder<HomePageCubit, HomePageState>(
                builder: (context, state) {
                  HomePageCubit cubit = context.read<HomePageCubit>();
                  if (state is HomePageLoading) {
                    return ShowLoadingIndicator();
                  } else if (state is HomePageLoaded) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        cubit.getHomePageData();
                      },
                      color: AppColors.white,
                      backgroundColor: AppColors.secondPrimary,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(height: getSize(context) / 3.5),
                          BannerWidget(sliderData: state.model.data!.sliders!),
                          //
                          state.model.data!.lifeExam != null
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
                  } else if (state is HomePageError) {
                    return NoDataWidget(
                      onclick: () {
                        context.read<HomePageCubit>().getHomePageData();
                      },
                      title: 'no_data'.tr(),
                    );
                  } else {
                    return NoDataWidget(
                      onclick: () {
                        context.read<HomePageCubit>().getHomePageData();
                      },
                      title: 'no_data'.tr(),
                    );
                  }
                },
              );
            } else {
              return NoDataWidget(
                onclick: () {
                  context.read<HomePageCubit>().getHomePageData();
                },
                title: 'no_internet'.tr(),
              );
            }
          }),
    );
  }
}
