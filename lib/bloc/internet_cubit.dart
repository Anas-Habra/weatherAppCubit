import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as net;

enum InternetState {
  connected,
  disconnected,
}

class InternetCubit extends Cubit<InternetState> {
  final net.InternetConnection internetConnection;

  InternetCubit()
      : internetConnection = net.InternetConnection(),
        super(InternetState.connected);

  Future<void> checkConnection() async {
    final hasConnection = await internetConnection.hasInternetAccess;
    emit(hasConnection ? InternetState.connected : InternetState.disconnected);
  }
}
