import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/booking/booking_event.dart';
import 'booking_state.dart';
import '../../repositories/booking_repository.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repo;

  BookingBloc(this.repo) : super(BookingInitial()) {
    on<CreateBookingEvent>((event, emit) async {
      emit(BookingLoading());

      try {
        await repo.createBooking(event.data);
        emit(BookingSuccess());
      } catch (e) {
        emit(BookingError("Booking failed"));
      }
    });
  }
}
