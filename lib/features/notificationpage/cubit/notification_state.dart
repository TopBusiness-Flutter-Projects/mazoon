part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationPageLoading extends NotificationState {}

class NotificationPageLoaded extends NotificationState {}

class NotificationPageError extends NotificationState {}

class ChangingSwitchCaseState extends NotificationState {}

class LoadingChangingSwitchCaseState extends NotificationState {}

class FailedToUpdateState extends NotificationState {}

class LoadingToUpdateState extends NotificationState {}

class SuccessUpdateState extends NotificationState {}
