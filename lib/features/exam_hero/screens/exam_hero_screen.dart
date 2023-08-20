import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/exam_hero/cubit/exam_hero_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../widgets/exam_hero_data_widget.dart';

class ExamHeroScreen extends StatefulWidget {
  const ExamHeroScreen({Key? key}) : super(key: key);

  @override
  State<ExamHeroScreen> createState() => _ExamHeroScreenState();
}

class _ExamHeroScreenState extends State<ExamHeroScreen>
    with TickerProviderStateMixin {
  List<String> titles = ['day'.tr(), 'week'.tr(), 'month'.tr()];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(context.read<ExamHeroCubit>().currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<ExamHeroCubit, ExamHeroState>(
              builder: (context, state) {
                ExamHeroCubit cubit = context.read<ExamHeroCubit>();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getSize(context)/3.5),
                    TitleWithCircleBackgroundWidget(
                      title: 'exam_hero',
                    ),
                    SizedBox(height: getSize(context)/30),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(
                              horizontal: getSize(context)/22,
                              vertical: getSize(context)/16,
                            ),
                            child: InkWell(
                              onTap: () {
                                cubit.selectTap(0);
                                print(cubit.currentIndex);
                                _tabController.animateTo(0);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getSize(context)/16,
                                  vertical: getSize(context)/30,
                                ),
                                decoration: BoxDecoration(
                                  color: cubit.currentIndex == 0
                                      ? AppColors.orangeThirdPrimary
                                      : AppColors.unselectedTabColor,
                                  borderRadius: BorderRadius.circular(getSize(context)/22),
                                ),
                                child: Center(
                                  child: Text(
                                    titles[0],
                                    style: TextStyle(
                                      color: cubit.currentIndex == 0
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          Padding(
                            padding:  EdgeInsets.symmetric(
                              horizontal: getSize(context)/16,
                              vertical: getSize(context)/30,
                            ),
                            child: InkWell(
                              onTap: () {
                                cubit.selectTap(1);
                                print(cubit.currentIndex);
                                _tabController.animateTo(1);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getSize(context)/16,
                                  vertical: getSize(context)/30,
                                ),
                                decoration: BoxDecoration(
                                  color: cubit.currentIndex == 1
                                      ? AppColors.orangeThirdPrimary
                                      : AppColors.unselectedTabColor,
                                  borderRadius: BorderRadius.circular(getSize(context)/22),
                                ),
                                child: Center(
                                  child: Text(
                                    titles[1],
                                    style: TextStyle(
                                      color: cubit.currentIndex == 1
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          Padding(
                            padding:  EdgeInsets.symmetric(
                              horizontal: getSize(context)/22,
                              vertical: getSize(context)/22,
                            ),
                            child: InkWell(
                              onTap: () {
                                cubit.selectTap(2);
                                print(cubit.currentIndex);
                                _tabController.animateTo(2);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getSize(context)/22,
                                  vertical: getSize(context)/22,
                                ),
                                decoration: BoxDecoration(
                                  color: cubit.currentIndex == 2
                                      ? AppColors.orangeThirdPrimary
                                      : AppColors.unselectedTabColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    titles[2],
                                    style: TextStyle(
                                      color: cubit.currentIndex == 2
                                          ? AppColors.white
                                          : AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          print(88888);
                        },
                        child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            ExamHeroDataWidget(),
                            ExamHeroDataWidget(),
                            ExamHeroDataWidget(),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
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
    );
  }
}
