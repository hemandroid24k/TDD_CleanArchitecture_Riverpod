import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_clean_architecture_riverpod/core/injection_container.dart';
import 'package:tdd_clean_architecture_riverpod/core/ui_state/ui_state.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/data/repository/login_repository_impl.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/entity/login_entity.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/repository/login_repository.dart';
import 'package:tdd_clean_architecture_riverpod/features/login/domain/usecase/login_usecase.dart';


final loginRepositoryProvider = Provider<LoginRepository>((ref) =>
    LoginRepositoryImpl(networkIOService: ref.read(connectivityServiceProvider)));


final postLoginFlowFutureProvider = FutureProvider.autoDispose.family<UiState<LoginEntity>, Map<String, String>>((ref, requestBody) async {
  return LoginUseCase(loginRepository: ref.read(loginRepositoryProvider)).call(requestBody);
});