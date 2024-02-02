import 'package:tdd_clean_architecture_riverpod/core/ui_state/ui_state.dart';
import 'package:tdd_clean_architecture_riverpod/core/usecases/usecase.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/entity/login_entity.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/repository/login_repository.dart';

class LoginUseCase implements UseCase<UiState<LoginEntity>, Map<String, String>>{

  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  @override
  Future<UiState<LoginEntity>> call(Map<String, String> params) {
    return loginRepository.goLogin(requestBody: params).then((LoginEntity response) => handleBackendSoftError(response));
  }

  UiState<LoginEntity> handleBackendSoftError(LoginEntity response) {
    if(response.success){
      return UiState(success: response);
    } else {
      return UiState(error: response.message);
    }
  }
}