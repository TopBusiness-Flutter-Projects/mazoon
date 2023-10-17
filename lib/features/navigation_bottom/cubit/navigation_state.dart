part of 'navigation_cubit.dart';

@immutable
abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class NavigationGetUserLoading extends NavigationState {}

class NavigationGetUserData extends NavigationState {}

class ExamRegisterLoadedState extends NavigationState {}

class ExamRegisterLoadingState extends NavigationState {}

class ExamRegisterErrorState extends NavigationState {}
