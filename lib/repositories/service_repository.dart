import 'dart:async';
import 'package:quickserve/services/api_service.dart';

class ServiceRepository {
  final _controller = StreamController<List<dynamic>>();

  Stream<List<dynamic>> get servicesStream => _controller.stream;

  void startFetching() {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      try {
        final data = await ApiService.getServices();
        _controller.add(data);
      } catch (e) {
        print("Err : $e");
        _controller.addError("Error fetching services");
      }
    });
  }

  void dispose() {
    _controller.close();
  }
}
