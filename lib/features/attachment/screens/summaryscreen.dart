import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/utils/hex_color.dart';
import 'package:new_mazoon/features/attachment/cubit/attachmentcubit.dart';
import 'package:new_mazoon/features/attachment/cubit/attachmentstate.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/dialogs.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/utils/pdfsize.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/pdf_screen.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttachmentCubit, AttachmentState>(
      listener: (context, state) {
        if (state is LoadingPdfAttchmentState) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        var cubit = context.read<AttachmentCubit>();

        return isLoading
            ? Center(child: CircularProgressIndicator())
            : cubit.pdfLessonData.isEmpty
                ? Center(
                    child: Text('no_data'.tr()),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(getSize(context) / 22),
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.pdfLessonData.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (cubit.pdfLessonData[index].status ==
                                      'opened') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PdfScreen(
                                                  pdfLink: cubit
                                                      .pdfLessonData[index]
                                                      .link!,
                                                  pdfTitle: cubit
                                                      .pdfLessonData[index]
                                                      .name!,
                                                )));
                                  } else {
                                    errorGetBar('have_access'.tr());
                                  }
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.all(getSize(context) / 22),
                                  margin:
                                      EdgeInsets.all(getSize(context) / 100),
                                  decoration: BoxDecoration(
                                      color: HexColor(cubit.pdfLessonData[index]
                                          .backgroundColor!),
                                      borderRadius: BorderRadius.circular(
                                          getSize(context) / 32)),
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.pdfLessonData[index].name!,
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: darken(
                                                    HexColor(cubit
                                                        .pdfLessonData[index]
                                                        .backgroundColor!),
                                                    0.4),
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    getSize(context) / 22),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    getSize(context) / 44),
                                            // child: Text(
                                            //   getPdfSize(cubit
                                            //               .pdfLessonData[index]
                                            //               .link)
                                            //           .toStringAsFixed(2) +
                                            //       ' MB',
                                            // style: TextStyle(
                                            //   color: darken(
                                            //       HexColor(cubit
                                            //           .pdfLessonData[index]
                                            //           .backgroundColor),
                                            //       0.4),
                                            //   ),
                                            // ),
                                            child: FutureBuilder<double>(
                                              future: getPdfSize(cubit
                                                  .pdfLessonData[index].link!),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Text(
                                                      ''); // Show a loading indicator while waiting
                                                } else if (snapshot.hasError ||
                                                    snapshot.data == -1) {
                                                  return Text('-MB',
                                                      style: TextStyle(
                                                          color: darken(
                                                              HexColor(cubit
                                                                  .pdfLessonData[
                                                                      index]
                                                                  .backgroundColor!),
                                                              0.4)));
                                                } else {
                                                  return Text(
                                                      '${snapshot.data!.toStringAsFixed(2)} MB',
                                                      style: TextStyle(
                                                          color: darken(
                                                              HexColor(cubit
                                                                  .pdfLessonData[
                                                                      index]
                                                                  .backgroundColor!),
                                                              0.4)));
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      CircleAvatar(
                                        //color from back
                                        backgroundColor: darken(
                                            HexColor(cubit.pdfLessonData[index]
                                                .backgroundColor!),
                                            0.4),
                                        child: MySvgWidget(
                                            path: cubit.pdfLessonData[index]
                                                        .status ==
                                                    'opened'
                                                ? ImageAssets.doneIcon
                                                : ImageAssets.lockIcon,
                                            imageColor: AppColors.white,
                                            size: getSize(context) / 22),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
      },
    );
  }
}
