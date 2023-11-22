import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/features/liveexam/cubit/cubit.dart';
import 'package:new_mazoon/features/liveexam/cubit/state.dart';
import '../widget/dropdownlist.dart';
import '../widget/heroitem.dart';
import '../widget/topthree.dart';

class LiveHeroes extends StatefulWidget {
  const LiveHeroes({super.key});

  @override
  State<LiveHeroes> createState() => _LiveHeroesState();
}

bool isloading = true;

class _LiveHeroesState extends State<LiveHeroes> {
  @override
  void initState() {
    context.read<LiveExamCubit>().getLiveHeroes(
        examId: context.read<LiveExamCubit>().examsMonthes.isEmpty
            ? "0"
            : context.read<LiveExamCubit>().examsMonthes[0].id.toString());
    ;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LiveExamCubit, LiveExamState>(
      listener: (context, state) {
        if (state is LoadingLiveHeroesState) {
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
              : cubit.liveHeroes == null
                  ? Center(
                      child: Text('no_data'.tr()),
                    )
                  : ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        LiveDropDownList(),
                        ThreeTopLiveExamHeroWidget(
                            threeHeros: cubit.liveHeroes!.allExamHeroes),
                        cubit.liveHeroes!.allExamHeroes.length <= 3
                            ? Container()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: cubit.allExamHeroes.length,
                                itemBuilder: (context, index) {
                                  return HeroItem(
                                      model: cubit.allExamHeroes[index]);
                                },
                              )
                      ],
                    ),
        );
      },
    );
  }
}
