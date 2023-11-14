abstract class PaymentState {}

class InitPaymentState extends PaymentState {}

class LoadingGetMonthesPaymentState extends PaymentState {}

class ErrorGetMonthesPaymentState extends PaymentState {}

class LoadedGetMonthesPaymentState extends PaymentState {}

class LoadingApplyDiscountPaymentState extends PaymentState {}

class LoadedApplyDiscountPaymentState extends PaymentState {}

class ErrorApplyDiscountPaymentState extends PaymentState {}

class LoadingApplyPaymentState extends PaymentState {}

class LoadedApplyPaymentState extends PaymentState {}

class ErrorApplyPaymentState extends PaymentState {}
