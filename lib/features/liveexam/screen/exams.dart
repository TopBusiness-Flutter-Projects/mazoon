import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/homePage/widget/live_exam_widget.dart';
import 'package:new_mazoon/features/liveexam/cubit/cubit.dart';
import 'package:new_mazoon/features/liveexam/cubit/state.dart';
import 'package:new_mazoon/features/liveexam/screen/liveexamresult.dart';

import '../widget/liveexamitem.dart';

class LiveExams extends StatefulWidget {
  const LiveExams({super.key});

  @override
  State<LiveExams> createState() => _LiveExamsState();
}

class _LiveExamsState extends State<LiveExams> {
  @override
  void initState() {
    context.read<LiveExamCubit>().getLiveExams();
    super.initState();
  }

  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveExamCubit, LiveExamState>(
      listener: (context, state) {
        if (state is LoadingLiveExamState) {
          isloading = true;
        } else {
          isloading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<LiveExamCubit>();
        return Scaffold(
          body: isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : cubit.liveExams.isEmpty
                  ? Center(
                      child: Text('no_data'.tr()),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.liveExams.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LiveExamResultScreen(
                                              id: cubit.liveExams[index].id
                                                  .toString())));
                            },
                            child: LiveExamItemWidget(index: index));
                      },
                    ),
        );
      },
    );
  }
}
