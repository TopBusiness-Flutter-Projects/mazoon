import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/widgets/no_data_widget.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';

import '../../../core/utils/hex_color.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../lessons_of_class/screens/lesson_class.dart';
import '../widgets/item_one_class_widget.dart';

class ClassesScreen extends StatefulWidget {
  ClassesScreen({Key? key}) : super(key: key);

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  int isLoading = 0;
  @override
  void initState() {
    context.read<StartTripCubit>().getExplanationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartTripCubit, StartTripState>(
      listener: (context, state) {
        if (state is StartTripExplanationLoading) {
          isLoading = 0;
        } else if (state is StartTripExplanationError) {
          isLoading = 1;
        } else {
          isLoading = 2;
        }
      },
      builder: (context, state) {
        StartTripCubit cubit = context.read<StartTripCubit>();
        return isLoading == 0
            ? ShowLoadingIndicator()
            : isLoading == 1
                ? NoDataWidget(
                    onclick: () {
                      cubit.getExplanationData();
                    },
                    title: 'no_date',
                  )
                : cubit.classesData.isEmpty
                    ? Center(
                        child: Text('no_date'.tr()),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          cubit.getExplanationData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.classesData.length,
                            itemBuilder: (BuildContext context, int index) {
                              print(cubit.classesData[index].totalTimes);
                              return InkWell(
                                onTap: () {
                                  if (cubit.classesData[index].status ==
                                      'lock') {
                                    toastMessage(
                                      'open_class'.tr(),
                                      context,
                                      color: AppColors.error,
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LessonsClassScreen(
                                          classId: cubit.classesData[index].id!,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: ItemOfOneClassWidget(
                                  classId: cubit.classesData[index].id!,
                                  classNum: cubit.classesData[index].title!,
                                  classTitle: cubit.classesData[index].name!,
                                  classPresentFinished: cubit
                                      .classesData[index].totalWatch
                                      .toString(),
                                  lessonNum: cubit
                                      .classesData[index].numOfLessons
                                      .toString(),
                                  videoNum: cubit.classesData[index].numOfVideos
                                      .toString(),
                                  hourNum: cubit.classesData[index].totalTimes
                                      .toString(),
                                  mainColor: HexColor(cubit
                                      .classesData[index].backgroundColor!),
                                  imagePath: cubit.classesData[index].image!,
                                  status: cubit.classesData[index].status!,
                                ),
                              );
                            },
                          ),
                        ),
                      );
      },
    );
  }
}
