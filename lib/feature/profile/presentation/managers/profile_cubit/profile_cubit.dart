import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/entities/user_entity.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getProfileUseCase) : super(ProfileInitial());

  final GetProfileUseCase _getProfileUseCase;

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    final result = await _getProfileUseCase.getProfile();
    switch (result) {
      case NetworkSuccess<UserEntity>():
        emit(GetProfileSuccess(result.data!));
      case NetworkFailure<UserEntity>():
        emit(GetProfileFailure(result.exception.toString()));
    }
  }
}
