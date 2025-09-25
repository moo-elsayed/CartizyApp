import 'package:cartizy_app_nti/core/dtos/user_request_dto.dart';
import 'package:cartizy_app_nti/core/entities/user_response_entity.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/profile/data/api/profile_api.dart';
import 'package:cartizy_app_nti/feature/profile/domain/entities/upload_entity.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/dtos/user_response_dto.dart';
import '../../../../../core/helpers/hive_helper.dart';
import '../../../domain/entities/user_request_entity.dart';
import '../../../domain/repo_contract/data_sources/profile_remote_data_source.dart';
import '../../dtos/response/upload_response_dto.dart';

class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImp(this._profileApi);

  final ProfileApi _profileApi;

  @override
  Future<NetworkResponse<UserResponseEntity>> getProfile() async {
    final response = await _profileApi.getProfile();
    switch (response) {
      case NetworkSuccess<UserResponseDto>():
        UserResponseEntity user =
            response.data?.toEntity() ?? const UserResponseEntity();
        _cacheProfile(user);
        return NetworkSuccess<UserResponseEntity>(user);
      case NetworkFailure<UserResponseDto>():
        return NetworkFailure<UserResponseEntity>(response.exception);
    }
  }

  @override
  Future<NetworkResponse<UploadEntity>> uploadImage(XFile file) async {
    final response = await _profileApi.uploadImage(file);
    switch (response) {
      case NetworkSuccess<UploadResponseDto>():
        return NetworkSuccess<UploadEntity>(response.data?.toEntity());
      case NetworkFailure<UploadResponseDto>():
        return NetworkFailure<UploadEntity>(response.exception);
    }
  }

  @override
  Future<NetworkResponse<UserResponseEntity>> updateProfile({
    required UserRequestEntity user,
    required int id,
  }) async {
    final response = await _profileApi.updateProfile(
      user: UserRequestDto.fromEntity(user),
      id: id,
    );
    switch (response) {
      case NetworkSuccess<UserResponseDto>():
        UserResponseEntity user =
            response.data?.toEntity() ?? const UserResponseEntity();
        _cacheProfile(user);
        return NetworkSuccess<UserResponseEntity>(user);
      case NetworkFailure<UserResponseDto>():
        return NetworkFailure<UserResponseEntity>(response.exception);
    }
  }

  Future<void> _cacheProfile(UserResponseEntity user) async {
    final box = await Hive.openBox<UserResponseEntity>(HiveHelper.profileBox);
    await box.clear();
    await box.add(user);
  }
}
