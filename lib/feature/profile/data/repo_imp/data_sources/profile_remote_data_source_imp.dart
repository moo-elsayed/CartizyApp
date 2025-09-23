import 'package:cartizy_app_nti/core/entities/user_entity.dart';
import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/profile/data/api/profile_api.dart';
import 'package:cartizy_app_nti/feature/profile/domain/repo_contract/data_sources/profile_remote_data_source.dart';
import '../../../../../core/dtos/user_response_dto.dart';

class ProfileRemoteDataSourceImp implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImp(this._profileApi);

  final ProfileApi _profileApi;

  @override
  Future<NetworkResponse<UserEntity>> getProfile() async {
    final response = await _profileApi.getProfile();
    switch (response) {
      case NetworkSuccess<UserResponseDto>():
        return NetworkSuccess<UserEntity>(response.data?.toEntity());
      case NetworkFailure<UserResponseDto>():
        return NetworkFailure<UserEntity>(response.exception);
    }
  }
}
