import 'dart:convert';

import 'package:tdd_clean_architecture_riverpod/core/environment/domain_config.dart';
import 'package:tdd_clean_architecture_riverpod/core/network/network_io_service.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/data/data_mapper/login_data_mapper.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/data/models/login_response_dto.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/entity/login_entity.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkIOService networkIOService;

  LoginRepositoryImpl({required this.networkIOService});

  @override
  Future<LoginEntity> goLogin({required Map<String, String> requestBody}) async {
    String baseUrl = DomainConfig().baseUrl;
    String url = "${baseUrl}login";
    final response = await networkIOService.post(url, requestData: json.encode(requestBody));
    // Parsing logic moved directly within goLogin
    final parsed = jsonDecode(response);
    LoginResponseDto loginResponseDto = LoginResponseDto.fromJson(parsed);
    return loginResponseDto.toLoginResponseEntity();
  }
}
