import '../services/api_service.dart';

class BookingRepository {
  Future<void> createBooking(Map<String, dynamic> data) async {
    final success = await ApiService.createBooking(data);

    if (!success) {
      throw Exception("Booking failed");
    }
  }
}