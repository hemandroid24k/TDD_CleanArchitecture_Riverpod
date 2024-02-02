import 'package:tdd_clean_architecture_riverpod/features/login/domain/entity/login_entity.dart';

abstract class LoginRepository{
  Future<LoginEntity> goLogin({required Map<String, String> requestBody});
}