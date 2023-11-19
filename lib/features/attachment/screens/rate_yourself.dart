import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../core/utils/string_to_double.dart';
import '../cubit/attachmentcubit.dart';
import '../cubit/attachmentstate.dart';

class RateYourSelfScreen extends StatefulWidget {
  const RateYourSelfScreen({super.key});

  @override
  State<RateYourSelfScreen> createState() => _RateYourSelfScreenState();
}

class _RateYourSelfScreenState extends State<RateYourSelfScreen> {
  bool isLoading = true;
  int currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return context.read<AttachmentCubit>().rateYourselfModelData == null
        ? Container(
            alignment: Alignment.center,
            height: getSize(context),
            child: Center(child: Text('rate_msg'.tr())))
        : BlocConsumer<AttachmentCubit, AttachmentState>(
            listener: (context, state) {
              if (state is LoadingRateYourselfttchmentState) {
                isLoading = true;
              } else if (state is SucessRateYourselfAttchmentState) {
                isLoading = false;
              } else {
                isLoading = false;
              }
            },
            builder: (context, state) {
              var cubit = context.read<AttachmentCubit>();
              // List<String> parts =
              //     cubit.rateYourselfModelData!.fullDegree.toString().split('/');
              // double numerator = double.parse(parts[0].trim());
              // double denominator = double.parse(parts[1].trim());
              // double result = numerator / denominator;
              return isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.all(getSize(context) / 32),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
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
                                      .rateYourselfModelData!.fullDegree
                                      .toString()),
                                  center: new Text(cubit
                                      .rateYourselfModelData!.fullDegree
                                      .toString()),
                                  progressColor: AppColors.greenDownloadColor,
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  cubit.rateYourselfModelData!.motivationalWord,
                                  style: TextStyle(
                                    fontSize: getSize(context) / 32,
                                    fontWeight: FontWeight.w200,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(getSize(context) / 22),
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
                                            borderRadius: BorderRadius.circular(
                                                getSize(context) / 66),
                                            color: AppColors.green),
                                        alignment: Alignment.center,
                                        child: Text(
                                            cubit.rateYourselfModelData!
                                                .correctNumbers
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: getSize(context) / 22,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white)),
                                      ),
                                      Text('right'.tr(),
                                          style: TextStyle(
                                            fontSize: getSize(context) / 32,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: getSize(context) / 10,
                                        width: getSize(context) / 10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                getSize(context) / 66),
                                            color: AppColors.red),
                                        alignment: Alignment.center,
                                        child: Text(
                                            cubit.rateYourselfModelData!
                                                .mistakeNumbers
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: getSize(context) / 22,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white)),
                                      ),
                                      Text('wrong'.tr(),
                                          style: TextStyle(
                                            fontSize: getSize(context) / 32,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: getSize(context) / 10,
                                        width: getSize(context) / 10,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                getSize(context) / 66),
                                            color: AppColors.purple1),
                                        alignment: Alignment.center,
                                        child: Text(
                                            cubit.rateYourselfModelData!
                                                .tryingNumbers
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: getSize(context) / 22,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white)),
                                      ),
                                      Text('trys'.tr(),
                                          style: TextStyle(
                                            fontSize: getSize(context) / 32,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Text('اضغط  على اى سؤال بالاسفل لمراجعت اجابتك',
                                style: TextStyle(
                                  fontSize: getSize(context) / 32,
                                  fontWeight: FontWeight.w700,
                                )),
                            SizedBox(height: getSize(context) / 44),
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: cubit.rateYourselfModelData!
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
                                    margin:
                                        EdgeInsets.all(getSize(context) / 100),
                                    child: CircleAvatar(
                                      radius: getSize(context) / 44,
                                      backgroundColor: cubit
                                                  .rateYourselfModelData!
                                                  .examQuestions
                                                  .questions[index]
                                                  .questionType ==
                                              'choice'
                                          ? cubit
                                                  .rateYourselfModelData!
                                                  .examQuestions
                                                  .questions[index]
                                                  .questionStatus
                                              ? AppColors.greenDownloadColor
                                              : AppColors.red
                                          : AppColors.greenDownloadColor,
                                      child: Text('${index + 1}',
                                          style: TextStyle(
                                              fontSize: getSize(context) / 32,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.white)),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: getSize(context) / 44),
                            Container(
                              margin: EdgeInsets.all(getSize(context) / 32),
                              padding: EdgeInsets.all(getSize(context) / 32),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(2, 3),
                                        color: AppColors.gray4,
                                        blurRadius: 8,
                                        spreadRadius: 0.5)
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      cubit
                                                  .rateYourselfModelData!
                                                  .examQuestions
                                                  .questions[currentQuestion]
                                                  .questionType ==
                                              'choice'
                                          ? "${currentQuestion + 1} - اختر الاجابة الصحيحة "
                                          : "${currentQuestion + 1} - مقالي",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: getSize(context) / 24,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.black)),
                                  Text(
                                      cubit.rateYourselfModelData!.examQuestions
                                          .questions[currentQuestion].question,
                                      style: TextStyle(
                                          fontSize: getSize(context) / 28,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.black)),

                                  ///
                                  cubit
                                              .rateYourselfModelData!
                                              .examQuestions
                                              .questions[currentQuestion]
                                              .questionType ==
                                          'choice'
                                      ? ListView.builder(
                                          itemCount: cubit
                                              .rateYourselfModelData!
                                              .examQuestions
                                              .questions[currentQuestion]
                                              .answers
                                              .length,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index2) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      getSize(context) / 32),
                                              padding: EdgeInsets.all(
                                                  getSize(context) / 44),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(
                                                      getSize(context) / 32),
                                                  color: (cubit.rateYourselfModelData!.examQuestions.questions[currentQuestion].answers[index2].id ==
                                                              cubit
                                                                  .rateYourselfModelData!
                                                                  .examQuestions
                                                                  .questions[
                                                                      currentQuestion]
                                                                  .answerUser &&
                                                          cubit
                                                                  .rateYourselfModelData!
                                                                  .examQuestions
                                                                  .questions[
                                                                      currentQuestion]
                                                                  .answers[
                                                                      index2]
                                                                  .answerStatus !=
                                                              'correct')
                                                      ? AppColors.bink
                                                      : cubit
                                                                  .rateYourselfModelData!
                                                                  .examQuestions
                                                                  .questions[
                                                                      currentQuestion]
                                                                  .answers[index2]
                                                                  .answerStatus ==
                                                              'un_correct'
                                                          ? AppColors.unselectedTabColor
                                                          : AppColors.greenDownloadColor,
                                                  border: Border.all(
                                                      color: (cubit.rateYourselfModelData!.examQuestions.questions[currentQuestion].answers[index2].id == cubit.rateYourselfModelData!.examQuestions.questions[currentQuestion].answerUser && cubit.rateYourselfModelData!.examQuestions.questions[currentQuestion].answers[index2].answerStatus != 'correct')
                                                          ? AppColors.red
                                                          : cubit.rateYourselfModelData!.examQuestions.questions[currentQuestion].answers[index2].answerStatus == 'un_correct'
                                                              ? AppColors.gray7
                                                              : AppColors.greenDownloadColor,
                                                      width: 2)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.white,
                                                    radius: cubit
                                                                .rateYourselfModelData!
                                                                .examQuestions
                                                                .questions[
                                                                    currentQuestion]
                                                                .answers[index2]
                                                                .answerStatus ==
                                                            'un_correct'
                                                        ? getSize(context) / 22
                                                        : cubit
                                                                    .rateYourselfModelData!
                                                                    .examQuestions
                                                                    .questions[
                                                                        currentQuestion]
                                                                    .answers[
                                                                        index2]
                                                                    .answerStatus ==
                                                                'correct'
                                                            ? getSize(context) /
                                                                22
                                                            : getSize(context) /
                                                                30,
                                                    child: MySvgWidget(
                                                        path: (cubit.rateYourselfModelData!.examQuestions.questions[currentQuestion].answers[index2].id ==
                                                                    cubit
                                                                        .rateYourselfModelData!
                                                                        .examQuestions
                                                                        .questions[
                                                                            currentQuestion]
                                                                        .answerUser &&
                                                                cubit
                                                                        .rateYourselfModelData!
                                                                        .examQuestions
                                                                        .questions[
                                                                            currentQuestion]
                                                                        .answers[
                                                                            index2]
                                                                        .answerStatus !=
                                                                    'correct')
                                                            ? ImageAssets.wrong
                                                            : cubit
                                                                        .rateYourselfModelData!
                                                                        .examQuestions
                                                                        .questions[
                                                                            currentQuestion]
                                                                        .answers[
                                                                            index2]
                                                                        .answerStatus ==
                                                                    'un_correct'
                                                                ? ImageAssets
                                                                    .whiteimage
                                                                : ImageAssets
                                                                    .doneIcon,
                                                        imageColor: (cubit
                                                                        .rateYourselfModelData!
                                                                        .examQuestions
                                                                        .questions[
                                                                            currentQuestion]
                                                                        .answers[
                                                                            index2]
                                                                        .id ==
                                                                    cubit
                                                                        .rateYourselfModelData!
                                                                        .examQuestions
                                                                        .questions[
                                                                            currentQuestion]
                                                                        .answerUser &&
                                                                cubit
                                                                        .rateYourselfModelData!
                                                                        .examQuestions
                                                                        .questions[currentQuestion]
                                                                        .answers[index2]
                                                                        .answerStatus !=
                                                                    'correct')
                                                            ? AppColors.red
                                                            : cubit.rateYourselfModelData!.examQuestions.questions[currentQuestion].answers[index2].answerStatus == 'un_correct'
                                                                ? AppColors.white
                                                                : AppColors.greenDownloadColor,
                                                        size: getSize(context) / 24),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          cubit
                                                              .rateYourselfModelData!
                                                              .examQuestions
                                                              .questions[
                                                                  currentQuestion]
                                                              .answers[index2]
                                                              .answer
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: getSize(
                                                                    context) /
                                                                24,
                                                            fontWeight:
                                                                FontWeight.w400,

                                                            ///check status
                                                            color: (cubit
                                                                            .rateYourselfModelData!
                                                                            .examQuestions
                                                                            .questions[
                                                                                currentQuestion]
                                                                            .answers[
                                                                                index2]
                                                                            .id ==
                                                                        cubit
                                                                            .rateYourselfModelData!
                                                                            .examQuestions
                                                                            .questions[
                                                                                currentQuestion]
                                                                            .answerUser &&
                                                                    cubit
                                                                            .rateYourselfModelData!
                                                                            .examQuestions
                                                                            .questions[
                                                                                currentQuestion]
                                                                            .answers[
                                                                                index2]
                                                                            .answerStatus !=
                                                                        'correct')
                                                                ? AppColors
                                                                    .white
                                                                : cubit
                                                                            .rateYourselfModelData!
                                                                            .examQuestions
                                                                            .questions[
                                                                                currentQuestion]
                                                                            .answers[
                                                                                index2]
                                                                            .answerStatus ==
                                                                        'un_correct'
                                                                    ? AppColors
                                                                        .black
                                                                    : AppColors
                                                                        .white,
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
                                              vertical: getSize(context) / 32),
                                          padding: EdgeInsets.all(
                                              getSize(context) / 44),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      getSize(context) / 32),
                                              color:
                                                  AppColors.unselectedTabColor,
                                              border: Border.all(
                                                  color: AppColors.gray7,
                                                  width: 2)),
                                          child: Text(
                                            cubit
                                                .rateYourselfModelData!
                                                .examQuestions
                                                .questions[currentQuestion]
                                                .answerUser,
                                            style: TextStyle(
                                                fontSize: getSize(context) / 28,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.black),
                                          ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
            },
          );
  }
}
