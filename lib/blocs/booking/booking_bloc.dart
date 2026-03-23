import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/booking/booking_event.dart';
import 'booking_state.dart';
import '../../repositories/booking_repository.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repo;

  BookingBloc(this.repo) : super(BookingInitial()) {
    on<CreateBookingEvent>((event, emit) async {
      emit(BookingLoading());

      // try {
      //   final success = await repo.createBooking(event.data);

      //   if (success) {
      //     emit(BookingSuccess());
      //   } else {
      //     emit(BookingError("Booking failed"));
      //   }
      // } catch (e) {
      //   emit(BookingError("Something went wrong"));
      // }
      on<CreateBookingEvent>((event, emit) async {
  emit(BookingLoading());

  try {
    await repo.createBooking(event.data);
    emit(BookingSuccess());
  } catch (e) {
    emit(BookingError(e.toString()));
  }
});
    });
  }
}