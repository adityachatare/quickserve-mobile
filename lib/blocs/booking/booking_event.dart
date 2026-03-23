import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// 📦 Create Booking
class CreateBookingEvent extends BookingEvent {
  final Map<String, dynamic> data;

  CreateBookingEvent(this.data);

  @override
  List<Object> get props => [data];
}