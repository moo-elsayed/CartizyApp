import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/profile/domain/entities/upload_entity.dart';
import 'package:cartizy_app_nti/feature/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:cartizy_app_nti/feature/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:cartizy_app_nti/feature/profile/domain/use_cases/upload_image_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/entities/user_response_entity.dart';
import '../../../domain/entities/user_request_entity.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._getProfileUseCase,
    this._uploadImageUseCase,
    this._updateProfileUseCase,
  ) : super(ProfileInitial());

  final GetProfileUseCase _getProfileUseCase;
  final UploadImageUseCase _uploadImageUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  XFile? photo;
  String? location;
  UserResponseEntity? user;

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    final result = await _getProfileUseCase.call();
    switch (result) {
      case NetworkSuccess<UserResponseEntity>():
        photo = null;
        location = null;
        user = result.data;
        emit(GetProfileSuccess());
      case NetworkFailure<UserResponseEntity>():
        emit(GetProfileFailure(result.exception.toString()));
    }
  }

  Future<void> selectAndUploadImage(ImageSource imageSource) async {
    try {
      final ImagePicker picker = ImagePicker();
      photo = await picker.pickImage(source: imageSource);
      if (photo != null) {
        emit(UploadImageLoading());
        final result = await _uploadImageUseCase.call(photo!);
        switch (result) {
          case NetworkSuccess<UploadEntity>():
            location = result.data?.location;
            emit(UploadImageSuccess());
          case NetworkFailure<UploadEntity>():
            emit(UploadImageFailure(result.exception.toString()));
        }
      }
    } catch (e) {
      emit(UploadImageFailure(e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(UpdateProfileLoading());
    final result = await _updateProfileUseCase.call(
      user: UserRequestEntity(
        name: name,
        email: email,
        password: password,
        avatar: location ?? user!.avatar,
      ),
      id: user!.id,
    );
    switch (result) {
      case NetworkSuccess<UserResponseEntity>():
        emit(UpdateProfileSuccess());
      case NetworkFailure<UserResponseEntity>():
        emit(UpdateProfileFailure(result.exception.toString()));
    }
  }
}
