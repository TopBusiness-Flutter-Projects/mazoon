import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/widgets/custom_button.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/examinstructions/widget/instructionsettingwidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/models/exam_instruction_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/network_image.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../cubit/examinstructions_cubit.dart';

class ExamInstructions extends StatefulWidget {
  const ExamInstructions({Key? key, required this.exam_id, required this.type})
      : super(key: key);
  final int exam_id;
  final String type;

  @override
  State<ExamInstructions> createState() => _ExamInstructionsState();
}

class _ExamInstructionsState extends State<ExamInstructions> {
  @override
  void initState() {
    super.initState();
    context
        .read<ExaminstructionsCubit>()
        .examInstructions(widget.exam_id, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    ExaminstructionsCubit cubit = context.read<ExaminstructionsCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondPrimary,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                child:
                    BlocBuilder<ExaminstructionsCubit, ExaminstructionsState>(
                  builder: (context, state) {
                    if (state is ExaminstructionsLoading) {
                      return ShowLoadingIndicator();
                    } else if (state is ExaminstructionsLoaded) {
                      ExamInstructionModel examinstructions =
                          state.examInstructionModel;
                      return SingleChildScrollView(

                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 105),
                              Text(
                                examinstructions.data!.details!.name!,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 20),
                                  InstructionSettingWidget(
                                      icon: ImageAssets.questionIcon,
                                      color: AppColors.orange,
                                      color2: AppColors.orangelight,
                                      title: examinstructions
                                          .data!.details!.numOfQuestion
                                          .toString() +
                                          "q".tr()),
                                  SizedBox(width: 20),
                                  InstructionSettingWidget(
                                      icon: ImageAssets.timeIcon,
                                      color: AppColors.blue,
                                      color2: AppColors.bluelight,
                                      title: examinstructions
                                              .data!.details!.totalTime
                                              .toString() +
                                          "min".tr()),
                                  SizedBox(width: 20),
                                  InstructionSettingWidget(
                                      icon: ImageAssets.loadIcon,
                                      color: AppColors.purple1,
                                      color2: AppColors.purple1light,
                                      title: examinstructions
                                          .data!.details!.tryingNumber!
                                          .toString() +
                                          "try".tr()),

                                  SizedBox(width: 20),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TitleWithCircleBackgroundWidget(
                             title: "best_result",

                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.bluelight,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 2),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,

                                          child: ManageNetworkImage(
                                            imageUrl:
                                                examinstructions.data!.user!.image!,
                                            width: 50,
                                            height: 50,
                                            borderRadius: 90,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                examinstructions
                                                    .data!.user!.name!,
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        EasyLocalization.of(
                                                                        context)!
                                                                    .currentLocale!
                                                                    .languageCode ==
                                                                'ar'
                                                            ? examinstructions
                                                                .data!
                                                                .user!
                                                                .city!
                                                                .nameAr!
                                                            : examinstructions
                                                                .data!
                                                                .user!
                                                                .city!
                                                                .nameEn!,
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        MySvgWidget(
                                                            path: ImageAssets
                                                                .timeIcon,
                                                            imageColor:
                                                                AppColors.blue,
                                                            size: 20),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          examinstructions.data!
                                                                  .user!.totalTime
                                                                  .toString() +
                                                              "min".tr(),
                                                          style: TextStyle(
                                                              color:
                                                                  AppColors.blue,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )
                                                    // SizedBox(width: 10),
                                                    ,
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 90,
                                          height: 90,
                                          child: SfCircularChart(
                                            palette: [AppColors.blue],
                                            annotations: <
                                                CircularChartAnnotation>[
                                              CircularChartAnnotation(
                                                widget: Center(
                                                  child: Center(
                                                    child: Container(
                                                      child: Center(
                                                        child: Text(
                                                          examinstructions
                                                                  .data!.user!.per
                                                                  .toString() +
                                                              "%",
                                                          style: TextStyle(
                                                            color: AppColors.blue,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: AppColors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            series: <CircularSeries>[
                                              RadialBarSeries<int, String>(
                                                maximumValue: 100,
                                                innerRadius: '20',
                                                dataSource: [
                                                  examinstructions
                                                      .data!.user!.per!
                                                      .toInt()
                                                ],
                                                strokeWidth: 8,
                                                cornerStyle: examinstructions
                                                            .data!.user!.per ==
                                                        100
                                                    ? CornerStyle.bothFlat
                                                    : CornerStyle.endCurve,
                                                xValueMapper: (int data, _) =>
                                                    data.toString(),
                                                yValueMapper: (int data, _) =>
                                                    double.parse(data.toString()),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 45),

                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              children: [
                                                MySvgWidget(
                                                    path: ImageAssets.timeIcon,
                                                    imageColor: AppColors.blue,
                                                    size: 20),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  examinstructions
                                                      .data!.user!.timeExam!,
                                                  style: TextStyle(
                                                      color: AppColors.blue,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: examinstructions.data!.details!.instruction!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
                                    child: Row(
                                      children: [
                                        Container(

                                          child: Center(
                                              child:
                                              Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.blue),
                                          )),

                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.bluelight),
                                          width: 30,
                                          height: 30,
                                        ),
                                        SizedBox(width: 7,),
                                        Expanded(
                                          child: Text(

                                           examinstructions.data!.details!.instruction![index],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 20,),
                              CustomButton(
                                text: "جاهز للامتحان .... ابدأ الان",
                                color: AppColors.orange,
                                onClick: () {},
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return NoDataWidget(
                        onclick: () =>
                            cubit.examInstructions(widget.exam_id, widget.type),
                        title: 'no_date',
                      );
                    }
                  },
                ),
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
}
