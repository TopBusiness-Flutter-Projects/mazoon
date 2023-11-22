import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/config/routes/app_routes.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/features/liveexam/cubit/cubit.dart';
import 'package:new_mazoon/features/liveexam/cubit/state.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/utils/string_to_double.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';

class LiveExamResultScreen extends StatefulWidget {
  LiveExamResultScreen(
      {required this.id, this.isFromLiveExam = false, super.key});
  String id;
  bool isFromLiveExam;
  @override
  State<LiveExamResultScreen> createState() => _LiveExamResultScreenState();
}

class _LiveExamResultScreenState extends State<LiveExamResultScreen> {
  bool loadApplyExam = true;
  @override
  void initState() {
    context.read<LiveExamCubit>().getResultExam(id: widget.id);
    super.initState();
  }

  bool isLoading = true;
  int currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveExamCubit, LiveExamState>(
      listener: (context, state) {
        if (state is LoadingGetLiveExamReslut) {
          isLoading = true;
        } else if (state is ErrorGetLiveExamReslut) {
          isLoading = true;
        } else if (state is LoadedGetLiveExamReslut) {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<LiveExamCubit>();
        // List<String> parts =
        //     cubit.resultExam!.data.studentDegree.toString().split('/');
        // double numerator = double.parse(parts[0].trim());
        // double denominator = double.parse(parts[1].trim());
        // double result = numerator / denominator;
        return WillPopScope(
          onWillPop: () async {
            if (widget.isFromLiveExam) {
              Navigator.pushReplacementNamed(
                  context, Routes.homePageScreenRoute);
            } else {
              Navigator.pop(context);
            }
            return Future<bool>.value(true);
          },
          child: SafeArea(
            child: Scaffold(
                body: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : cubit.resultExam == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(getSize(context) / 32),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(height: getSize(context) / 3),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('نتيجة الاختبار',
                                            style: TextStyle(
                                              fontSize: getSize(context) / 32,
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ),
                                      Stack(
                                        children: [
                                          CircularPercentIndicator(
                                            backgroundColor: AppColors.offWiite,
                                            radius: getSize(context) / 8,
                                            lineWidth: getSize(context) / 32,
                                            percent: resultOfProgress(cubit
                                                .resultExam!.data.studentDegree
                                                .toString()),
                                            center: new Text(
                                              cubit.resultExam!.data
                                                  .studentDegree
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      getSize(context) / 32,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            progressColor:
                                                AppColors.greenDownloadColor,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            cubit.resultExam!.data
                                                .motivationalWord,
                                            style: TextStyle(
                                              fontSize: getSize(context) / 32,
                                              fontWeight: FontWeight.w200,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            getSize(context) / 22),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: getSize(context) / 10,
                                                  width: getSize(context) / 10,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              getSize(context) /
                                                                  66),
                                                      color: AppColors.green),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      cubit.resultExam!.data
                                                          .numOfCorrectQuestions
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              getSize(context) /
                                                                  22,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.white)),
                                                ),
                                                Text('right'.tr(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          getSize(context) / 32,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  height: getSize(context) / 10,
                                                  width: getSize(context) / 10,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              getSize(context) /
                                                                  66),
                                                      color: AppColors.red),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      cubit.resultExam!.data
                                                          .numOfMistakeQuestions
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              getSize(context) /
                                                                  22,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.white)),
                                                ),
                                                Text('wrong'.tr(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          getSize(context) / 32,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  height: getSize(context) / 10,
                                                  width: getSize(context) / 10,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              getSize(context) /
                                                                  66),
                                                      color: AppColors.purple1),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      cubit.resultExam!.data
                                                          .ordered
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              getSize(context) /
                                                                  22,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.white)),
                                                ),
                                                Text('my_order'.tr(),
                                                    style: TextStyle(
                                                      fontSize:
                                                          getSize(context) / 32,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                          'اضغط  على اى سؤال بالاسفل لمراجعت اجابتك',
                                          style: TextStyle(
                                            fontSize: getSize(context) / 32,
                                            fontWeight: FontWeight.w700,
                                          )),
                                      SizedBox(height: getSize(context) / 44),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: cubit.resultExam!.data
                                            .examQuestions.questions.length,
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 10),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                currentQuestion = index;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(
                                                  getSize(context) / 100),
                                              child: CircleAvatar(
                                                radius: getSize(context) / 44,
                                                backgroundColor: cubit
                                                            .resultExam!
                                                            .data
                                                            .examQuestions
                                                            .questions[index]
                                                            .questionType ==
                                                        "choice"
                                                    ? cubit
                                                            .resultExam!
                                                            .data
                                                            .examQuestions
                                                            .questions[index]
                                                            .questionStatus
                                                        ? AppColors
                                                            .greenDownloadColor
                                                        : AppColors.red
                                                    : AppColors
                                                        .greenDownloadColor,
                                                child: Text('${index + 1}',
                                                    style: TextStyle(
                                                        fontSize:
                                                            getSize(context) /
                                                                32,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            AppColors.white)),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: getSize(context) / 44),
                                      Container(
                                        margin: EdgeInsets.all(
                                            getSize(context) / 32),
                                        padding: EdgeInsets.all(
                                            getSize(context) / 32),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(2, 3),
                                                  color: AppColors.gray4,
                                                  blurRadius: 8,
                                                  spreadRadius: 0.5)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                cubit
                                                            .resultExam!
                                                            .data
                                                            .examQuestions
                                                            .questions[
                                                                currentQuestion]
                                                            .questionType ==
                                                        "choice"
                                                    ? "${currentQuestion + 1} - اختر الاجابة الصحيحة "
                                                    : "${currentQuestion + 1} - مقالي",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize:
                                                        getSize(context) / 24,
                                                    fontWeight: FontWeight.w900,
                                                    color: AppColors.black)),
                                            Text(
                                                cubit
                                                    .resultExam!
                                                    .data
                                                    .examQuestions
                                                    .questions[currentQuestion]
                                                    .question,
                                                style: TextStyle(
                                                    fontSize:
                                                        getSize(context) / 28,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.black)),

                                            cubit
                                                        .resultExam!
                                                        .data
                                                        .examQuestions
                                                        .questions[
                                                            currentQuestion]
                                                        .image ==
                                                    null
                                                ? Container()
                                                : Image.network(cubit
                                                    .resultExam!
                                                    .data
                                                    .examQuestions
                                                    .questions[currentQuestion]
                                                    .image!),

                                            ///
                                            cubit
                                                        .resultExam!
                                                        .data
                                                        .examQuestions
                                                        .questions[
                                                            currentQuestion]
                                                        .questionType ==
                                                    "choice"
                                                ? ListView.builder(
                                                    itemCount: cubit
                                                        .resultExam!
                                                        .data
                                                        .examQuestions
                                                        .questions[
                                                            currentQuestion]
                                                        .answers
                                                        .length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index2) {
                                                      return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: getSize(
                                                                        context) /
                                                                    32),
                                                        padding: EdgeInsets.all(
                                                            getSize(context) /
                                                                44),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        getSize(context) /
                                                                            32),
                                                                color: (cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].id ==
                                                                            cubit
                                                                                .resultExam!
                                                                                .data
                                                                                .examQuestions
                                                                                .questions[
                                                                                    currentQuestion]
                                                                                .answerUser &&
                                                                        cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].answerStatus !=
                                                                            'correct')
                                                                    ? AppColors
                                                                        .bink
                                                                    : cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].answerStatus ==
                                                                            'un_correct'
                                                                        ? AppColors
                                                                            .unselectedTabColor
                                                                        : AppColors
                                                                            .greenDownloadColor,
                                                                border: Border.all(
                                                                    color: (cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].id == cubit.resultExam!.data.examQuestions.questions[currentQuestion].answerUser && cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].answerStatus != 'correct')
                                                                        ? AppColors.red
                                                                        : cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].answerStatus == 'un_correct'
                                                                            ? AppColors.gray7
                                                                            : AppColors.greenDownloadColor,
                                                                    width: 2)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  AppColors
                                                                      .white,
                                                              radius: cubit
                                                                          .resultExam!
                                                                          .data
                                                                          .examQuestions
                                                                          .questions[
                                                                              currentQuestion]
                                                                          .answers[
                                                                              index2]
                                                                          .answerStatus ==
                                                                      'un_correct'
                                                                  ? getSize(
                                                                          context) /
                                                                      22
                                                                  : cubit
                                                                              .resultExam!
                                                                              .data
                                                                              .examQuestions
                                                                              .questions[
                                                                                  currentQuestion]
                                                                              .answers[
                                                                                  index2]
                                                                              .answerStatus ==
                                                                          'correct'
                                                                      ? getSize(
                                                                              context) /
                                                                          22
                                                                      : getSize(
                                                                              context) /
                                                                          30,
                                                              child: MySvgWidget(
                                                                  path: (cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].id == cubit.resultExam!.data.examQuestions.questions[currentQuestion].answerUser && cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].answerStatus != 'correct')
                                                                      ? ImageAssets.wrong
                                                                      : cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].answerStatus == 'un_correct'
                                                                          ? ImageAssets.whiteimage
                                                                          : ImageAssets.doneIcon,
                                                                  imageColor: (cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].id == cubit.resultExam!.data.examQuestions.questions[currentQuestion].answerUser && cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].answerStatus != 'correct')
                                                                      ? AppColors.red
                                                                      : cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].answerStatus == 'un_correct'
                                                                          ? AppColors.white
                                                                          : AppColors.greenDownloadColor,
                                                                  size: getSize(context) / 24),
                                                            ),
                                                            Flexible(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                    cubit
                                                                        .resultExam!
                                                                        .data
                                                                        .examQuestions
                                                                        .questions[
                                                                            currentQuestion]
                                                                        .answers[
                                                                            index2]
                                                                        .answer
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          getSize(context) /
                                                                              24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,

                                                                      ///check status
                                                                      color: (cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].id == cubit.resultExam!.data.examQuestions.questions[currentQuestion].answerUser &&
                                                                              cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].answerStatus !=
                                                                                  'correct')
                                                                          ? AppColors
                                                                              .white
                                                                          : cubit.resultExam!.data.examQuestions.questions[currentQuestion].answers[index2].answerStatus == 'un_correct'
                                                                              ? AppColors.black
                                                                              : AppColors.white,
                                                                    )),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Container(
                                                    margin: EdgeInsets.symmetric(
                                                        vertical:
                                                            getSize(context) /
                                                                32),
                                                    padding: EdgeInsets.all(
                                                        getSize(context) / 44),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                getSize(context) /
                                                                    32),
                                                        color: AppColors
                                                            .unselectedTabColor,
                                                        border: Border.all(
                                                            color: AppColors.gray7,
                                                            width: 2)),
                                                    child: Text(
                                                      cubit
                                                          .resultExam!
                                                          .data
                                                          .examQuestions
                                                          .questions[
                                                              currentQuestion]
                                                          .answerUser
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              getSize(context) /
                                                                  28,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              AppColors.black),
                                                    ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                child: HomePageAppBarWidget(
                                  isHome: false,
                                  liveExam: true,
                                ),
                              ),
                            ],
                          )),
          ),
        );
      },
    );
  }
}
