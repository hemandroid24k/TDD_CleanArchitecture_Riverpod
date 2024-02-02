import 'package:tdd_clean_architecture_riverpod/features/login/data/models/login_response_dto.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/entity/login_entity.dart';

extension LoginResponseMapper on LoginResponseDto{
  LoginEntity toLoginResponseEntity() {
    return LoginEntity(success: success, message: message, token: token);
  }
}