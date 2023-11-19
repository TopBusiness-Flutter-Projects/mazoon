part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomeGetUserLoading extends HomePageState {}

class HomeGetUserData extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final HomePageModel model;

  HomePageLoaded(this.model);
}

class HomePageError extends HomePageState {}

class HomePageLoadingClass extends HomePageState {}

class HomePageLoadedClass extends HomePageState {}

class HomePageErrorClass extends HomePageState {}

class UserScreenshotLoadingClass extends HomePageState {}

class UserScreenshotLoadedClass extends HomePageState {}

class UserScreenshotErrorClass extends HomePageState {}

class HomePageLiveLoadingClass extends HomePageState {}

class HomePageLiveLoadedClass extends HomePageState {}

class HomePageLiveErrorClass extends HomePageState {}

class HomePageLiveTimerClass extends HomePageState {}

class HomePageApplyLiveLoadingClass extends HomePageState {}

class HomePageApplyLiveLoadedClass extends HomePageState {}

class HomePageApplyLiveErrorClass extends HomePageState {}
