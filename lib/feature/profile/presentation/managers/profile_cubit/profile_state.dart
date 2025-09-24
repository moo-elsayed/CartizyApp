part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileLoading extends ProfileState {}

final class GetProfileSuccess extends ProfileState {}

final class GetProfileFailure extends ProfileState {
  GetProfileFailure(this.errorMessage);

  final String errorMessage;
}

final class UploadImageLoading extends ProfileState {}

final class UploadImageSuccess extends ProfileState {}

final class UploadImageFailure extends ProfileState {
  UploadImageFailure(this.errorMessage);

  final String errorMessage;
}

final class UpdateProfileLoading extends ProfileState {}

final class UpdateProfileSuccess extends ProfileState {}

final class UpdateProfileFailure extends ProfileState {
  UpdateProfileFailure(this.errorMessage);

  final String errorMessage;
}
