import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import 'package:new_mazoon/features/liveexam/cubit/cubit.dart';
import 'package:new_mazoon/features/start_trip/cubit/start_trip_cubit.dart';
import '../../../core/utils/app_colors.dart';

class LiveDropDownList extends StatefulWidget {
  LiveDropDownList({
    super.key,
  });

  @override
  State<LiveDropDownList> createState() => _LiveDropDownListState();
}

class _LiveDropDownListState extends State<LiveDropDownList> {
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();

    context.read<StartTripCubit>().getExamClassesData();
    
  }

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

  String title = 'choose_class'.tr();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartTripCubit, StartTripState>(
      builder: (context, state) {
        var cubit = context.read<LiveExamCubit>();
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ExpansionTile(
                    iconColor: AppColors.white,
                    key: keyTile,
                    trailing: Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 35,
                      color: AppColors.white,
                    ),
                    backgroundColor: AppColors.orangeThirdPrimary,
                    collapsedBackgroundColor:
                        darken(AppColors.orangeThirdPrimary, 0.05),
                    title: Text(
                      title,
                      style: TextStyle(color: AppColors.white),
                    ),
                    children: [
                      ...List.generate(
                        cubit.examsMonthes.length,
                        (index) => ListTile(
                          title: Text(
                            cubit.examsMonthes[index].name,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: getSize(context) / 28,
                              fontWeight:
                                  title == cubit.examsMonthes[index].name
                                      ? FontWeight.bold
                                      : null,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              title = cubit.examsMonthes[index].name;
                            });
                            cubit.getLiveHeroes(
                                examId:
                                    cubit.examsMonthes[index].id.toString());
                          },
                        ),
                      ),
                    ],
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
  }
}
