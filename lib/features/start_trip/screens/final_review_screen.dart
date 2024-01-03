import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/getsize.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../cubit/start_trip_cubit.dart';
import '../widgets/item_final_review_widget.dart';

class FinalReviewScreen extends StatelessWidget {
  FinalReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartTripCubit, StartTripState>(
      builder: (context, state) {
        StartTripCubit cubit = context.read<StartTripCubit>();
        if (state is StartTripFinalReviewLoading) {
          return ShowLoadingIndicator();
        }
        if (state is StartTripFinalReviewError) {
          return NoDataWidget(
            onclick: () {
              cubit.getExplanationData();
            },
            title: 'no_date',
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            cubit.getFinalReviewData();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: getSize(context) / 44,
              right: getSize(context) / 44,
            ),
            child: ListView(
              children: [
                SizedBox(height: getSize(context) / 66),
                cubit.finalReview.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: getSize(context) / 66,
                            crossAxisCount: 2),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.finalReview.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemOfFinalReviewWidget(
                            model: cubit.finalReview[index],
                          );
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.15),
                          Image.asset(
                            ImageAssets.comingSoonImage,
                            width: getSize(context) / 4,
                            height: getSize(context) / 5,
                          ),
                          SizedBox(height: getSize(context) / 22),
                          Visibility(
                            visible: cubit.finalReview.isEmpty,
                            child: Text(
                              'coming_soon'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                SizedBox(height: getSize(context) / 22),
              ],
            ),
          ),
        );
      },
    );
  }
}
