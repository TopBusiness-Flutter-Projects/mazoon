import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';
import 'package:new_mazoon/features/homePage/cubit/home_page_cubit.dart';
import '../../../core/models/liveexamapplydata.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/utils/app_colors.dart';

class LiveExamQuestions extends StatefulWidget {
  LiveExamQuestions({required this.examId, super.key});
  String examId;
  @override
  State<LiveExamQuestions> createState() => _LiveExamQuestionsState();
}

class _LiveExamQuestionsState extends State<LiveExamQuestions> {
  // List data = [];
  ScrollController _scrollController = ScrollController();

  void scrollToNextItem() {
    _scrollController.animateTo(
      _scrollController.position.pixels - 100,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrollToPreviousItem() {
    _scrollController.animateTo(
      _scrollController.position.pixels + 100,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  int _minutesLeft = 0;
  int _secondsLeft = 0;
  bool _isActive = false;
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_minutesLeft == 0 && _secondsLeft == 0) {
          _isActive = false;
          _timer!.cancel();
        } else if (_secondsLeft == 0) {
          _minutesLeft--;
          _secondsLeft = 59;
        } else if (_minutesLeft == 0 && _secondsLeft == 1) {
          // context.read<QuestionsLessonExamCubit>().tryAtEndOfExam(
          //     lessonId: widget.lessonId,
          //     context: context,
          //     type: widget.exam_type,
          //     time: _minutesLeft);
          // context.read<QuestionsLessonExamCubit>().applyLessonExam(
          //     lessonId: widget.lessonId,
          //     minutesLeft: _minutesLeft,
          //     exam_type: widget.exam_type,
          // context: context);
          context.read<HomePageCubit>().applyLiveExam(context: context);
          Fluttertoast.showToast(msg: 'exam_out'.tr());
          setState(() {
            _isActive = true;
            _minutesLeft = context.read<HomePageCubit>().quizMinutes;
            _secondsLeft = 0;
          });
        } else {
          _secondsLeft--;
        }
      });
    });
  }

  @override
  void initState() {
    context
        .read<HomePageCubit>()
        .getLiveExamQuestions(id: widget.examId.toString());
    setState(() {
      _isActive = true;
      _minutesLeft = context.read<HomePageCubit>().quizMinutes;
      _secondsLeft = 0;
    });
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    _scrollController.dispose();

    super.dispose();
  }

  bool isLoading = true;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        if (state is HomePageLiveLoadingClass) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<HomePageCubit>();
        return WillPopScope(
          onWillPop: () async {
            // Navigator.pop(context);
            return Future<bool>.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
              backgroundColor: AppColors.secondPrimary,
            ),
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : SafeArea(
                    child: Stack(
                      children: [
                        cubit.liveExamQuestions!.data.questions.isEmpty
                            ? Scaffold(
                                body: Center(
                                  child: Text('have_q'.tr()),
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: getSize(context) / 3.5),
                                    SizedBox(height: getSize(context) / 8),
                                    Flexible(
                                      child: ListView(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        children: [
                                          Container(
                                            height: getSize(context) / 12,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'rest_time'.tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: getSize(context) / 22,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: getSize(context) / 3,
                                            alignment: Alignment.center,
                                            child: CircularPercentIndicator(
                                              radius: 45.0,
                                              lineWidth: 9.0,
                                              percent: ((_minutesLeft * 60 +
                                                              _secondsLeft) -
                                                          (cubit.quizMinutes *
                                                              60))
                                                      .abs() /
                                                  (cubit.quizMinutes * 60),
                                              backgroundColor:
                                                  Colors.transparent,
                                              center: SizedBox(
                                                width: getSize(context) / 4,
                                                height: getSize(context) / 12,
                                                child: Text(
                                                  '${(_minutesLeft ~/ 60).toString().padLeft(2, '0')}:${(_minutesLeft % 60).toString().padLeft(2, '0')}:${(_secondsLeft).toString().padLeft(2, '0')}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AppColors.blue5,
                                                    fontSize:
                                                        getSize(context) / 28,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              progressColor: AppColors.blue5,
                                            ),
                                          ),
                                          ////number of questions >>>>>
                                          Container(
                                            height: getSize(context) / 10,
                                            alignment: Alignment.center,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    color: AppColors.blue5,
                                                    onPressed: () {
                                                      setState(() {
                                                        scrollToNextItem();
                                                      });
                                                    },
                                                    icon: Transform.rotate(
                                                      angle: 3,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                          color:
                                                              AppColors.blue5,
                                                          Icons
                                                              .arrow_back_ios_new_outlined),
                                                    )),
                                                Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        controller:
                                                            _scrollController,
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        itemCount: cubit
                                                            .liveExamQuestions!
                                                            .data
                                                            .questions
                                                            .length,
                                                        itemBuilder:
                                                            (context, index3) {
                                                          return Container(
                                                              child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                index = index3;
                                                              });
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .all(getSize(
                                                                          context) /
                                                                      100),
                                                              child: CircleAvatar(
                                                                  backgroundColor: (cubit.liveExamQuestions!.data.questions[index3].isSolving == false && index3 < index)
                                                                      ? AppColors.red
                                                                      : index3 == index
                                                                          ? AppColors.blue5
                                                                          : cubit.liveExamQuestions!.data.questions[index3].isSolving == true
                                                                              ? AppColors.greenDownloadColor
                                                                              : AppColors.unselectedTabColor,
                                                                  child: Text(
                                                                    (index3 + 1)
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize: getSize(context) / 22,
                                                                        fontWeight: FontWeight.bold,
                                                                        color: index3 == index
                                                                            ? AppColors.white
                                                                            : (cubit.liveExamQuestions!.data.questions[index3].isSolving == false && index3 < index)
                                                                                ? AppColors.white
                                                                                : cubit.liveExamQuestions!.data.questions[index3].isSolving == true
                                                                                    ? AppColors.white
                                                                                    : AppColors.primary),
                                                                  )),
                                                            ),
                                                          ));
                                                        },
                                                      ),
                                                    )),
                                                IconButton(
                                                    color: AppColors.blue5,
                                                    onPressed: () {
                                                      scrollToPreviousItem();
                                                    },
                                                    icon: Icon(
                                                      color: AppColors.blue5,
                                                      Icons
                                                          .arrow_back_ios_new_outlined,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          ////questions >>>>>
                                          SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(
                                                      getSize(context) / 32),
                                                  padding: EdgeInsets.all(
                                                      getSize(context) / 32),
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset:
                                                                Offset(2, 3),
                                                            color:
                                                                AppColors.gray4,
                                                            blurRadius: 8,
                                                            spreadRadius: 0.5)
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${index + 1}-${cubit.liveExamQuestions!.data.questions[index].questionType == 'choice' ? '${'choose_q'.tr()}' : '${'write_q'.tr()}'}",
                                                            style: TextStyle(
                                                                fontSize: getSize(
                                                                        context) /
                                                                    24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: AppColors
                                                                    .black)),
                                                        Column(
                                                          children: [
                                                            Text(
                                                                cubit
                                                                    .liveExamQuestions!
                                                                    .data
                                                                    .questions[
                                                                        index]
                                                                    .question,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        getSize(context) /
                                                                            24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    color: AppColors
                                                                        .black)),
                                                            cubit
                                                                        .liveExamQuestions!
                                                                        .data
                                                                        .questions[
                                                                            index]
                                                                        .image !=
                                                                    null
                                                                ? ManageNetworkImage(
                                                                    imageUrl: cubit
                                                                        .liveExamQuestions!
                                                                        .data
                                                                        .questions[
                                                                            index]
                                                                        .image!,
                                                                  )
                                                                : Container()
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height: getSize(
                                                                    context) /
                                                                44),

                                                        ///answer
                                                        ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          itemCount: cubit
                                                              .liveExamQuestions!
                                                              .data
                                                              .questions[index]
                                                              .answers
                                                              .length,
                                                          itemBuilder: (context,
                                                              index2) {
                                                            return Container(
                                                                margin: EdgeInsets.symmetric(
                                                                    vertical:
                                                                        getSize(context) /
                                                                            32),
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        getSize(context) /
                                                                            44),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(getSize(context) /
                                                                            32),
                                                                    color: AppColors
                                                                        .unselectedTabColor,
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .gray7,
                                                                        width:
                                                                            2)),
                                                                child:
                                                                    RadioListTile(
                                                                  activeColor:
                                                                      AppColors
                                                                          .blue5,
                                                                  value: cubit
                                                                      .liveExamQuestions!
                                                                      .data
                                                                      .questions[
                                                                          index]
                                                                      .answers[
                                                                          index2]
                                                                      .answer,
                                                                  groupValue: cubit
                                                                      .liveExamQuestions!
                                                                      .data
                                                                      .questions[
                                                                          index]
                                                                      .answers[
                                                                          index2]
                                                                      .selectedValue,
                                                                  onChanged:
                                                                      (e) {
                                                                    setState(
                                                                        () {
                                                                      cubit
                                                                          .liveExamQuestions!
                                                                          .data
                                                                          .questions[
                                                                              index]
                                                                          .answers
                                                                          .forEach(
                                                                              (answer) {
                                                                        answer.selectedValue =
                                                                            e.toString();
                                                                      });
                                                                    });
                                                                    cubit.solveQuestion(
                                                                        index);

                                                                    cubit.liveExamQuestions!.data.questions[index].answers[index2].selectedValue !=
                                                                            ''
                                                                        ? cubit.addUniqueApplyMakeExam(ApplyLiveExamModel(
                                                                            question:
                                                                                cubit.liveExamQuestions!.data.questions[index].id.toString(),
                                                                            answer: cubit.liveExamQuestions!.data.questions[index].answers[index2].id.toString()))
                                                                        : null;
                                                                  },
                                                                  title: Row(
                                                                    children: [
                                                                      Flexible(
                                                                        fit: FlexFit
                                                                            .tight,
                                                                        child:
                                                                            Text(
                                                                          cubit
                                                                              .liveExamQuestions!
                                                                              .data
                                                                              .questions[index]
                                                                              .answers[index2]
                                                                              .answer,
                                                                          style: TextStyle(
                                                                              fontSize: getSize(context) / 24,
                                                                              fontWeight: FontWeight.w900,
                                                                              color: AppColors.black),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ));
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    cubit.applyLiveExam(
                                                        context: context);
                                                    // cubit.applyLessonExam(
                                                    //   minutesLeft: _minutesLeft,
                                                    //   context: context,
                                                    //   lessonId: widget.lessonId,
                                                    //   exam_type: widget.exam_type,
                                                    // );
                                                    // cubit.tryAtEndOfExam(
                                                    //     lessonId: widget.lessonId,
                                                    //     context: context,
                                                    //     type: widget.exam_type,
                                                    //     time: cubit
                                                    //             .questionOfLessonData!
                                                    //             .quizMinute -
                                                    //         _minutesLeft);
                                                  },
                                                  child: Container(
                                                      margin: EdgeInsets.all(
                                                          getSize(context) /
                                                              22),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .greenDownloadColor,
                                                          borderRadius: BorderRadius
                                                              .circular(getSize(
                                                                      context) /
                                                                  22)),
                                                      padding: EdgeInsets.all(
                                                          getSize(context) /
                                                              28),
                                                      child: Text(
                                                        'finish_exam'.tr(),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .white),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                        ///
                        // Positioned(
                        //   top: 0,
                        //   right: 0,
                        //   left: 0,
                        //   child: HomePageAppBarWidget(),
                        // ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
