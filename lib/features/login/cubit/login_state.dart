part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class userInitial extends LoginState {}

class userLoading extends LoginState {}

class userLoaded extends LoginState {
  final UserModel userModel;

  userLoaded(this.userModel);
}

class userError extends LoginState {}

class userCommunicationLoading extends LoginState {}

class userCommunicationLoaded extends LoginState {}

class userCommunicationError extends LoginState {}

class DeviceTokenSuccess extends LoginState {}

class DeviceTokenError extends LoginState {}

class setNotificationTokenLoading extends LoginState {}

class setNotificationTokenLoaded extends LoginState {}

class setNotificationTokenError extends LoginState {}
