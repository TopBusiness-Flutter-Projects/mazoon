import 'package:easy_localization/easy_localization.dart' as tras;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/widgets/title_with_circle_background_widget.dart';
import 'package:new_mazoon/features/lessons_of_class/screens/videosoflessonscreen.dart';

import '../../../core/models/lessons_model.dart';
import '../../../core/utils/getsize.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/lessons_class_cubit.dart';
import '../cubit/lessons_class_state.dart';
import 'lessonexam.dart';

class LessonDetails extends StatefulWidget {
  LessonDetails({required this.model, super.key});
  AllLessonsModel model;

  @override
  State<LessonDetails> createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails>
    with TickerProviderStateMixin {
  ///lesson of class
  List<String> titles = [
    'expnain'.tr(),
    'less_exam'.tr(),
  ];

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: titles.length, vsync: this);
    _tabController.animateTo(context.read<LessonsClassCubit>().currentIndex);
    //get data and open first lesson video

    BlocProvider.of<LessonsClassCubit>(context).videosofLessons = [];
    BlocProvider.of<LessonsClassCubit>(context)
        .getVideosofLessonsData(widget.model.id!);
    //need handle in UI
    context.read<LessonsClassCubit>().examsofLessons = [];
    BlocProvider.of<LessonsClassCubit>(context)
        .getExamsofLessonsData(widget.model.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: BlocBuilder<LessonsClassCubit, LessonsClassState>(
        builder: (context, state) {
          var controller = context.read<LessonsClassCubit>();
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getSize(context) / 3),
                    TitleWithCircleBackgroundWidget(
                        width: double.infinity,
                        height: getSize(context) / 6,
                        /////////////
                        title: '${widget.model.title} : ${widget.model.name}'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            titles.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(
                                8,
                              ),
                              child: InkWell(
                                onTap: () {
                                  controller.selectTap(index);
                                  print(controller.currentIndex);
                                  _tabController.animateTo(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: controller.currentIndex == index
                                        ? AppColors.orangeThirdPrimary
                                        : AppColors.unselectedTabColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      titles[index],
                                      style: TextStyle(
                                          color:
                                              controller.currentIndex == index
                                                  ? AppColors.white
                                                  : AppColors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: getSize(context) / 24),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: TabBarView(
                        controller: _tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          VideoLessonScreen(model: widget.model),
                          LessonExamScreen(model: widget.model),
                        ],
                      ),
                    )
                  ],
                ),

                ///
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: HomePageAppBarWidget(
                    isHome: false,
                    // isLessonOfClass: true,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
