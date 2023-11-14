import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/models/applydiscount.dart';
import 'package:new_mazoon/core/utils/app_colors.dart';
import 'package:new_mazoon/core/utils/assets_manager.dart';
import 'package:new_mazoon/core/utils/dialogs.dart';
import 'package:new_mazoon/core/widgets/custom_app_bar.dart';
import 'package:new_mazoon/core/widgets/custom_appbar_widget.dart';
import 'package:new_mazoon/core/widgets/my_svg_widget.dart';
import 'package:new_mazoon/features/payment/cubit/paymentcubit.dart';
import 'package:new_mazoon/features/payment/cubit/paymentstate.dart';
import '../../../core/utils/getsize.dart';
import '../../../core/widgets/title_with_circle_background_widget.dart';
import '../../homePage/widget/home_page_app_bar_widget.dart';

class SelectMonthPlanPayment extends StatefulWidget {
  const SelectMonthPlanPayment({super.key});

  @override
  State<SelectMonthPlanPayment> createState() => _SelectMonthPlanPaymentState();
}

class _SelectMonthPlanPaymentState extends State<SelectMonthPlanPayment> {
  @override
  void initState() {
    BlocProvider.of<PaymentCubit>(context).getAllMonthes();
    super.initState();
  }

  bool isLoading = true;

  List<Color> colors = [
    Color(0xff009541),
    Color(0xff48B8E0),
    Color(0xff854AA4)
  ];
  @override
  void dispose() {
    context.read<PaymentCubit>().calResonse = null;
    context.read<PaymentCubit>().couponController.clear();
    context.read<PaymentCubit>().monthes = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<PaymentCubit>().calResonse = null;
        context.read<PaymentCubit>().couponController.clear();
        context.read<PaymentCubit>().monthes = [];
        Navigator.pop(context);
        return Future(() => false);
      },
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is LoadingGetMonthesPaymentState) {
            isLoading = true;
          } else {
            isLoading = false;
          }
        },
        builder: (context, state) {
          var cubit = context.read<PaymentCubit>();
          return SafeArea(
            child: Scaffold(
              body: isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    )
                  : Stack(
                      children: [
                        ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(height: getSize(context) / 3),
                            TitleWithCircleBackgroundWidget(
                                width: double.infinity,
                                title: 'select_month'.tr()),
                            ListView.builder(
                              itemCount: cubit.allMonths.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return cubit.allMonths[index].content.isEmpty
                                    ? Container()
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        height: getSize(context) / 2.5,
                                        // color: index % 2 == 0
                                        //     ? Colors.blue
                                        //     : Colors.red,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Row(
                                              children: [
                                                Checkbox(
                                                    value: cubit
                                                        .allMonths[index]
                                                        .isSelected,
                                                    shape: CircleBorder(),
                                                    activeColor: Colors.green,
                                                    onChanged: (newValue) {
                                                      ///if true add else remove from list
                                                      if (cubit.calResonse !=
                                                          null) {
                                                        errorGetBar(
                                                            'p_complete_order'
                                                                .tr());
                                                      } else {
                                                        setState(() {
                                                          cubit.allMonths[index]
                                                                  .isSelected =
                                                              newValue;
                                                        });
                                                        //
                                                        // cubit.addUniqueApplyPayment(
                                                        //     ApplyDiscount(
                                                        //         id: cubit
                                                        //             .allMonths[
                                                        //                 index]
                                                        //             .id,
                                                        //         price: cubit
                                                        //             .allMonths[
                                                        //                 index]
                                                        //             .price,
                                                        //         coupon: cubit
                                                        //             .couponController
                                                        //             .text));
                                                      }
                                                    }),
                                                Text(
                                                  cubit.allMonths[index].name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            )),
                                            Flexible(
                                                child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              children: [
                                                ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount: cubit
                                                      .allMonths[index]
                                                      .content
                                                      .length,
                                                  itemBuilder:
                                                      (context, index2) {
                                                    return Container(
                                                      height:
                                                          getSize(context) / 3,
                                                      width: getSize(context) /
                                                          2.2,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 2),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              colors[index % 3],
                                                          borderRadius: BorderRadius
                                                              .circular(getSize(
                                                                      context) /
                                                                  44)),
                                                      child: Column(
                                                        children: [
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: Text(
                                                              cubit
                                                                  .allMonths[
                                                                      index]
                                                                  .content[
                                                                      index2]
                                                                  .name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .white,
                                                                fontSize: getSize(
                                                                        context) /
                                                                    28,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            2),
                                                                child: Icon(
                                                                    Icons
                                                                        .watch_later_outlined,
                                                                    color: AppColors
                                                                        .white,
                                                                    size: getSize(
                                                                            context) /
                                                                        22),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  cubit
                                                                      .allMonths[
                                                                          index]
                                                                      .content[
                                                                          index2]
                                                                      .time,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontSize:
                                                                        getSize(context) /
                                                                            36,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '+',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                            child: MySvgWidget(
                                                                path: ImageAssets
                                                                    .studyIcon,
                                                                imageColor:
                                                                    colors[
                                                                        index %
                                                                            3],
                                                                size: getSize(
                                                                        context) /
                                                                    10),
                                                          ),
                                                          Text(
                                                            '${'sources_references'.tr()}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ))
                                          ],
                                        ),
                                      );
                              },
                            ),
                            (cubit.calResonse != null)
                                ? cubit.couponController.text.isEmpty
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'coupon'.tr(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: getSize(context) / 22,
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: cubit
                                                        .couponController.text,
                                                    style: TextStyle(
                                                      fontSize:
                                                          getSize(context) / 22,
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              textAlign: TextAlign.right,
                                            )
                                          ],
                                        ),
                                      )
                                : Container(
                                    height: getSize(context) / 3,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: getSize(context) / 16,
                                        vertical: getSize(context) / 22),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(1, 1),
                                            color: Colors.grey,
                                            blurRadius: 5,
                                          )
                                        ],
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 32)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: getSize(context) / 88),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: TextFormField(
                                          controller: cubit.couponController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'coupon'.tr()),
                                        )),
                                        cubit.calResonse != null
                                            ? Container()
                                            : InkWell(
                                                onTap: () {
                                                  cubit.calMonthList();
                                                  if (cubit.monthes.isEmpty) {
                                                    errorGetBar(
                                                        'select_months'.tr());
                                                  } else {
                                                    if (cubit.calResonse ==
                                                            null &&
                                                        cubit.couponController
                                                            .text.isNotEmpty) {
                                                      cubit.calDiscount(
                                                          context: context);
                                                    } else {
                                                      errorGetBar(
                                                          'enter_coupon'.tr());
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  'use'.tr(),
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color: Color(0xFF009541),
                                                    fontSize:
                                                        getSize(context) / 28,
                                                    fontFamily: 'Cairo',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                            cubit.calResonse == null
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'total_demond'.tr(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: getSize(context) / 22,
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: cubit
                                                    .calResonse!.data.total
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      getSize(context) / 22,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor:
                                                      AppColors.red,
                                                  decorationThickness: 3,
                                                  fontFamily: 'Cairo',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'eg'.tr(),
                                                style: TextStyle(
                                                  fontSize:
                                                      getSize(context) / 22,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor:
                                                      AppColors.red,
                                                  decorationThickness: 3,
                                                  fontFamily: 'Cairo',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.right,
                                        )
                                      ],
                                    ),
                                  ),
                            cubit.calResonse == null
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'total_price_after_discount'.tr(),
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: getSize(context) / 22,
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: cubit.calResonse!.data
                                                            .totalAfterDiscount ==
                                                        0
                                                    ? cubit
                                                        .calResonse!.data.total
                                                        .toString()
                                                    : cubit.calResonse!.data
                                                        .totalAfterDiscount
                                                        .toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      getSize(context) / 22,
                                                  fontFamily: 'Cairo',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'eg'.tr(),
                                                style: TextStyle(
                                                  fontSize:
                                                      getSize(context) / 22,
                                                  fontFamily: 'Cairo',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.right,
                                        )
                                      ],
                                    ),
                                  ),
                            SizedBox(height: getSize(context) / 22),
                            Container(
                              height: getSize(context) / 7,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(
                                  horizontal: getSize(context) / 6),
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(
                                      getSize(context) / 12)),
                              child: InkWell(
                                onTap: () {
                                  cubit.calMonthList();
                                  if (cubit.monthes.isEmpty) {
                                    errorGetBar('select_months'.tr());
                                  } else {
                                    if (cubit.calResonse == null) {
                                      cubit.calDiscount(context: context);
                                    } else {
                                      cubit.applyPayment(context: context);
                                    }
                                  }
                                },
                                child: Container(
                                  child: cubit.calResonse == null
                                      ? Text(
                                          'total_demond'.tr(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: getSize(context) / 22,
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        )
                                      : Text(
                                          'complete_order'.tr(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: getSize(context) / 22,
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: getSize(context) / 22),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: HomePageAppBarWidget(
                            isHome: false,
                            isPayment: true,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
