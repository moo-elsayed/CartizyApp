part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileLoading extends ProfileState {}

final class GetProfileSuccess extends ProfileState {
  GetProfileSuccess(this.user);

  final UserEntity user;
}

final class GetProfileFailure extends ProfileState {
  GetProfileFailure(this.errorMessage);

  final String errorMessage;
}
