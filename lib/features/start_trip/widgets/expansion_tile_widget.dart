import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/sources_and_references/cubit/source_references_cubit.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../lessons_of_class/cubit/lessons_class_cubit.dart';

class ExpansionTileWidget extends StatefulWidget {
  final String title;
  final String type;
  bool isGray;
  bool isHaveLesson;
  bool isLesson;
  bool isClass;

  ExpansionTileWidget(
      {super.key,
      this.isGray = false,
      this.isLesson = false,
      this.isHaveLesson = false,
      required this.title,
      this.isClass = false,
      required this.type});

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    title = widget.title;
  }

  String title = '';
  UniqueKey keyTile = UniqueKey();

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsClassCubit, LessonsClassState>(
      builder: (context, state) {
        return BlocBuilder<StartTripCubit, StartTripState>(
          builder: (context, state) {
            StartTripCubit cubit = context.read<StartTripCubit>();
            var cubit2 = context.read<LessonsClassCubit>();

            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ExpansionTile(
                        iconColor:
                            widget.isGray ? AppColors.black : AppColors.white,
                        key: keyTile,
                        trailing: Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 35,
                          color:
                              widget.isGray ? AppColors.black : AppColors.white,
                        ),
                        backgroundColor: widget.isGray
                            ? AppColors.unselectedTabColor
                            : AppColors.orangeThirdPrimary,
                        collapsedBackgroundColor: darken(
                            widget.isGray
                                ? AppColors.unselectedTabColor
                                : AppColors.orangeThirdPrimary,
                            0.05),
                        // textColor: AppColors.white,
                        title: Text(
                          title,
                          style: TextStyle(
                              color: widget.isGray
                                  ? AppColors.black
                                  : AppColors.white),
                        ),
                        children: [
                          ...List.generate(
                            cubit.examClasses.length,
                            (index) => ListTile(
                              title: Text(
                                cubit.examClasses[index].title!,
                                style: TextStyle(
                                  color:
                                      title == cubit.examClasses[index].title!
                                          ? AppColors.primary
                                          : widget.isGray
                                              ? AppColors.black
                                              : AppColors.white,
                                  fontSize:
                                      title == cubit.examClasses[index].title!
                                          ? 20
                                          : 16,
                                  fontWeight:
                                      title == cubit.examClasses[index].title!
                                          ? FontWeight.bold
                                          : null,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  cubit.examClasses[index].status == 'lock'
                                      ? MySvgWidget(
                                          size: 16,
                                          imageColor: widget.isGray
                                              ? AppColors.black
                                              : AppColors.white,
                                          path: ImageAssets.lockIcon,
                                        )
                                      : SizedBox(),
                                  SizedBox(width: 8),
                                  widget.type == 'source'
                                      ? SizedBox()
                                      : Container(
                                          width: 25,
                                          height: 25,
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: title ==
                                                    cubit.examClasses[index]
                                                        .title!
                                                ? AppColors.primary
                                                : AppColors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              cubit.examClasses[index]
                                                  .numOfLessons
                                                  .toString(),
                                              style: TextStyle(
                                                color: title ==
                                                        cubit.examClasses[index]
                                                            .title!
                                                    ? AppColors.white
                                                    : AppColors
                                                        .orangeThirdPrimary,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              onTap: () {
                                if (cubit.examClasses[index].status != 'lock') {
                                  isExpanded ? shrinkTile() : expandTile();
                                  title = cubit.examClasses[index].title!;
                                  setState(() {
                                    title = cubit.examClasses[index].title!;
                                  });

                                  if (widget.type == 'source') {
                                    context
                                        .read<SourceReferencesCubit>()
                                        .sourcesAndReferencesDataById(
                                            cubit2.oneClass.id!);
                                  } else {
                                    if (widget.isHaveLesson) {
                                      cubit2.getLessonsClassData(
                                          cubit.examClasses[index].id!,
                                          cubit2.lessons[index].id!,
                                          context,
                                          widget.isGray,
                                          widget.isLesson,
                                          widget.isClass);

                                      //
                                    } else {
                                      cubit.getExamsClassByIdData(
                                        cubit.examClasses[index].id!,
                                      );

                                      //
                                    }
                                  }
                                } else {
                                  toastMessage(
                                    'هذا الفصل لم يفتح بعد',
                                    context,
                                    color: AppColors.error,
                                  );
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                                width: double.infinity,
                                height: 2,
                                color: widget.isGray
                                    ? AppColors.black
                                    : AppColors.white),
                          ),
                          ListTile(
                            title: Text(
                              'امتحانات شاملة على الفصول',
                              style: TextStyle(
                                color: title == 'امتحانات شاملة على الفصول'
                                    ? AppColors.primary
                                    : AppColors.liveExamGrayTextColor,
                                fontSize: title == 'امتحانات شاملة على الفصول'
                                    ? 20
                                    : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              isExpanded ? shrinkTile() : expandTile();
                              title = 'امتحانات شاملة على الفصول';
                              setState(() {
                                title = 'امتحانات شاملة على الفصول';
                              });
                            },
                          )
                        ],
                        onExpansionChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: state is StartTripExamClassesLoading,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircularProgressIndicator(
                      color: AppColors.orangeThirdPrimary,
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
