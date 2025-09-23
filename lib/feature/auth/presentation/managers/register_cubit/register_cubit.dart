import 'package:cartizy_app_nti/core/helpers/network_response.dart';
import 'package:cartizy_app_nti/core/entities/user_entity.dart';
import 'package:cartizy_app_nti/feature/auth/domain/use_cases/register_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

  final RegisterUseCase _registerUseCase;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    var result = await _registerUseCase.call(
      name: name,
      email: email,
      password: password,
    );

    switch (result) {
      case NetworkSuccess<UserEntity>():
        emit(RegisterSuccess());
      case NetworkFailure<UserEntity>():
        emit(RegisterFailure(result.toString()));
    }
  }
}
