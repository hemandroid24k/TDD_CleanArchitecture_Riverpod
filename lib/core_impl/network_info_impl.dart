import 'package:connectivity_plus/connectivity_plus.dart';
import '../core/network/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async => (await connectionChecker.checkConnectivity()) != ConnectivityResult.none;
}
