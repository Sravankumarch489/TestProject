import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity connectivity;
  ConnectivityService({required this.connectivity});

  Future<bool> getNetworkStatus() async {
    var connectivityResult = await (connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}

final ConnectivityService connectivityService =
    ConnectivityService(connectivity: Connectivity());
