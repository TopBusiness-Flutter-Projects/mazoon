import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_mazoon/core/models/subscrabtion.dart';
import 'package:new_mazoon/core/utils/dialogs.dart';
import 'package:new_mazoon/core/widgets/show_loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/models/applydiscount.dart';
import '../../../core/models/discountmodel.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/show_dialog.dart';
import './paymentstate.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.api) : super(InitPaymentState());

  ServiceApi api;
  List<SubscriptionsDataModel> allMonths = [];

  getAllMonthes() async {
    emit(LoadingGetMonthesPaymentState());
    final response = await api.getAllMonthPlan();
    response.fold((l) {
      emit(ErrorGetMonthesPaymentState());
    }, (r) {
      allMonths = r.data;
      emit(LoadedGetMonthesPaymentState());
    });
  }

  CalculateDiscountModel? calResonse;
  TextEditingController couponController = TextEditingController();
  List<ApplyDiscount> monthes = [];
  calMonthList() {
    for (int i = 0; i < allMonths.length; i++) {
      if (allMonths[i].isSelected == true) {
        monthes.add(ApplyDiscount(
            id: allMonths[i].id,
            price: allMonths[i].price,
            coupon: couponController.text));
      }
    }
  }

  calDiscount({required BuildContext context}) async {
    // for (int i = 0; i < allMonths.length; i++) {
    //   if (allMonths[i].isSelected == true) {
    //     monthes.add(ApplyDiscount(
    //         id: allMonths[i].id,
    //         price: allMonths[i].price,
    //         coupon: couponController.text));
    //   }
    // }
    createProgressDialog(context, 'wait'.tr());
    emit(LoadingApplyDiscountPaymentState());
    final response =
        await api.calDiscount(coupon: couponController.text, monthes: monthes);
    response.fold((l) {
      Navigator.pop(context);
      emit(ErrorApplyDiscountPaymentState());
    }, (r) {
      calResonse = r;
      if (r.code == 200) {
        successGetBar(r.message);
      } else {
        errorGetBar(r.message);
      }
      Navigator.pop(context);
      // couponController.clear();
      emit(LoadedApplyDiscountPaymentState());
    });
  }

  // addUniqueApplyPayment(ApplyDiscount item) {
  //   int isfound = -1;
  //   if (monthes.isEmpty) {
  //     monthes.add(item);
  //     print('..................first....................' +
  //         monthes.length.toString());
  //   } else {
  //     for (int i = 0; i < monthes.length; i++) {
  //       if (monthes[i].id == item.id) {
  //         isfound = i;
  //         monthes.removeWhere((element) => element.id == item.id);
  //         print(
  //             '...........remove................' + monthes.length.toString());
  //       } else {
  //         print('..........else 1...................' +
  //             monthes.length.toString());
  //       }
  //       if (monthes[i].id == item.id) {
  //         isfound = i;
  //         print('...........found....................' +
  //             monthes.length.toString());

  //         return;
  //       }
  //     }
  //     if (isfound != -1) {
  //       monthes.removeAt(isfound);
  //       print('........R......................' + monthes.length.toString());
  //     } else {
  //       print('...........add....................' + monthes.length.toString());
  //       monthes.add(item);
  //     }
  //   }
  //   print('......................................' + monthes.length.toString());
  // }

  applyPayment({required BuildContext context}) async {
    createProgressDialog(context, 'wait'.tr());

    emit(LoadingApplyPaymentState());
    final response = await api.applyPayment(
        totalPrice: calResonse!.data.totalAfterDiscount == 0
            ? calResonse!.data.total.toString()
            : calResonse!.data.totalAfterDiscount.toString());
    response.fold((l) {
      //s
      Navigator.pop(context);
      emit(ErrorApplyPaymentState());
    }, (r) async {
      //
      Navigator.pop(context);
      Navigator.pop(context);

      await launchUrl(
        Uri.parse(r.data),
        mode: LaunchMode.inAppWebView,
      );
      emit(LoadedApplyPaymentState());
    });
  }

  ///
}
