import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial
class BookingInitial extends BookingState {}

// Loading
class BookingLoading extends BookingState {}

// Success
class BookingSuccess extends BookingState {}

// Error
class BookingError extends BookingState {
  final String message;

  BookingError(this.message);

  @override
  List<Object> get props => [message];
}