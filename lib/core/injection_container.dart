import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_architecture_riverpod/core/routes/app_router_config.dart';
import 'package:tdd_clean_architecture_riverpod/core_impl/network_IO_service_impl.dart';
import 'package:tdd_clean_architecture_riverpod/core_impl/network_info_impl.dart';

final internetConnectionChecker = Provider((ref) => Connectivity());
final httpClientProvider = Provider((ref) => http.Client());
final networkInfoProvider = Provider((ref) => NetworkInfoImpl(ref.read(internetConnectionChecker)));

final connectivityServiceProvider = Provider((ref) => NetworkIOServiceImpl(
    client: ref.read(httpClientProvider),
    networkInfo: ref.read(networkInfoProvider)));

final appRouterConfigProvider = Provider((ref) => AppRouterConfig());

final routerProvider = Provider((ref) => ref.watch(appRouterConfigProvider).appRouterConfig);
