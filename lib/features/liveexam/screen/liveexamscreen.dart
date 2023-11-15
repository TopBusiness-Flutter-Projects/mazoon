import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/liveexam/cubit/cubit.dart';
import 'package:new_mazoon/features/liveexam/cubit/state.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import 'exams.dart';
import 'heroes.dart';

class LiveExamScreen extends StatefulWidget {
  const LiveExamScreen({super.key});

  @override
  State<LiveExamScreen> createState() => _LiveExamScreenState();
}

class _LiveExamScreenState extends State<LiveExamScreen>
    with TickerProviderStateMixin {
  List<String> titles = ['exam'.tr(), 'live_hero'.tr()];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(context.read<LiveExamCubit>().currentIndex);
    context.read<LiveExamCubit>().getLiveHeroesMonthes();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveExamCubit, LiveExamState>(
      listener: (context, state) {
        if (state is LoadingGetSelctedMonthList) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<LiveExamCubit>();
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          SizedBox(height: getSize(context) / 3),
                          TitleWithCircleBackgroundWidget(
                              width: double.infinity, title: 'live'.tr()),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  titles.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: InkWell(
                                      onTap: () {
                                        cubit.selectTap(index);
                                        print(cubit.currentIndex);
                                        _tabController.animateTo(index);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: getSize(context) / 10,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: cubit.currentIndex == index
                                              ? AppColors.orangeThirdPrimary
                                              : AppColors.unselectedTabColor,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Center(
                                          child: Text(
                                            titles[index],
                                            style: TextStyle(
                                                color:
                                                    cubit.currentIndex == index
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    getSize(context) / 24),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          ////

                          Flexible(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                print(88888);
                              },
                              child: TabBarView(
                                controller: _tabController,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  LiveExams(),
                                  LiveHeroes(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: HomePageAppBarWidget(
                    isHome: false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
