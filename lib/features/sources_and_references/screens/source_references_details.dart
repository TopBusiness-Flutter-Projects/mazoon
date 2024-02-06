import 'dart:io';
import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/widgets/network_image.dart';
import 'package:new_mazoon/features/sources_and_references/cubit/source_references_cubit.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/change_to_mega_byte.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/download_icon_widget.dart';
import '../../../core/widgets/pdf_screen.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';
import '../../start_trip/widgets/expansion_tile_widget.dart';
import '../widgets/source_references_details_item_widget.dart';

class SourceReferencesDetails extends StatelessWidget {
  SourceReferencesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<SourceReferencesCubit>().sourcesReferencesByIdList.clear();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondPrimary,
          toolbarHeight: 0,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<SourceReferencesCubit, SourceReferencesState>(
                builder: (context, state) {
                  SourceReferencesCubit cubit =
                      context.read<SourceReferencesCubit>();
                  return ListView(
                    children: [
                      SizedBox(height: getSize(context) / 3),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          // padding: EdgeInsets.all(12),
                          height: getSize(context) / 3.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColors.greenDownloadColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cubit.referenceModel.progress == 0 &&
                                      File(cubit.dirpath.path +
                                              "/pdf/" +
                                              cubit.referenceModel.title!
                                                  .split("/")
                                                  .toList()
                                                  .last +
                                              '.pdf')
                                          .existsSync()
                                  ? SizedBox(
                                      width: getSize(context) / 12,
                                      height: getSize(context) / 12,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: AppColors.success,
                                      ))
                                  : cubit.referenceModel.progress != 0
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            value:
                                                cubit.referenceModel.progress,
                                            backgroundColor: AppColors.white,
                                            color: AppColors.primary,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            print('00:00');
                                            cubit.downloadPdf(
                                                cubit.referenceModel);
                                          },
                                          child: Container(
                                            color: Colors.blue,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DownloadIconWidget(
                                                color: AppColors.white,
                                                iconColor: AppColors
                                                    .greenDownloadColor,
                                              ),
                                            ),
                                          ),
                                        ),

                              Flexible(
                                fit: FlexFit.tight,
                                child: InkWell(
                                  onTap: () {
                                    print(cubit.referenceModel.filePath);
                                    print("cubit.referenceModel.filePath");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PdfScreen(
                                          pdfTitle: cubit.referenceModel.title!,
                                          pdfLink:
                                              cubit.referenceModel.filePath!,
                                        ),
                                      ),
                                    );

                                    ///read video
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'click_to_download'.tr(),
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: getSize(context) / 22),
                                        ),
                                        Text(
                                          changeToMegaByte(cubit
                                              .referenceModel.filePathSize!),
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: getSize(context) / 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  print(cubit.referenceModel.filePath);
                                  print("cubit.referenceModel.filePath");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfScreen(
                                        pdfTitle: cubit.referenceModel.title!,
                                        pdfLink: cubit.referenceModel.filePath!,
                                      ),
                                    ),
                                  );

                                  ///read video
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ManageNetworkImage(
                                      imageUrl: cubit.referenceModel.icon!,
                                      height: getSize(context) / 6,
                                      width: getSize(context) / 3,
                                      borderRadius: 8,
                                    ),
                                  ],
                                ),
                              )
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.end,
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.only(left: 8.0),
                              //       child: StrokeText(
                              //         text: "",
                              //         textStyle: TextStyle(
                              //             fontSize: 45,
                              //             fontFamily: 'Mada',
                              //             color: AppColors.error),
                              //         strokeColor: AppColors.white,
                              //         strokeWidth: 4,
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ExpansionTileWidget(
                        title: 'select_class'.tr(),
                        type: 'source',
                      ),
                      SizedBox(height: 20),
                      state is SourceReferencesByIdLoading
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                            )
                          : SourceReferenceDetailsItemWidget(),
                    ],
                  );
                },
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: HomePageAppBarWidget(isHome: false, isSource: true)),
            ],
          ),
        ),
      ),
    );
  }
}
