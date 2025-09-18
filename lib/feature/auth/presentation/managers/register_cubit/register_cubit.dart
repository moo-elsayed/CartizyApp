import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/feature/auth/data/DTOs/response/register_response_dto.dart';
import 'package:cartizy_app_nti/feature/auth/domain/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/DTOs/request/register_request_dto.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authRepo) : super(RegisterInitial());

  final AuthRepo _authRepo;

  Future<void> register({required String name,required String email,required String password}) async {
    emit(RegisterLoading());
    final request = RegisterRequestDto(
      name: name,
      email: email,
      password: password,
    );

    var result = await _authRepo.register(request);

    switch (result) {
      case NetworkSuccess<RegisterResponseDto>():
        emit(RegisterSuccess());
      case NetworkFailure<RegisterResponseDto>():
        emit(RegisterFailure(result.exception.toString()));
    }
  }
}
