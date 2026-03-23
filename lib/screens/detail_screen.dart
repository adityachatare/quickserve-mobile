import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/booking/booking_bloc.dart';
import '../blocs/booking/booking_event.dart';
import '../blocs/booking/booking_state.dart';
import '../repositories/booking_repository.dart';

class DetailScreen extends StatelessWidget {
  final Map service;
  final address = TextEditingController();

  DetailScreen({required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(BookingRepository()),
      child: Scaffold(
        appBar: AppBar(title: Text(service['name'])),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: BlocConsumer<BookingBloc, BookingState>(
            listener: (context, state) {
              if (state is BookingSuccess) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Booked Successfully")));
              }

              if (state is BookingError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Text(service['description']),
                  Text("₹${service['price']}"),

                  TextField(
                    controller: address,
                    decoration: InputDecoration(labelText: "Address"),
                  ),

                  SizedBox(height: 20),

                  if (state is BookingLoading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: () {
                        context.read<BookingBloc>().add(
                              CreateBookingEvent({
                                "serviceId": service['_id'],
                                "date": DateTime.now().toString(),
                                "address": address.text,
                              }),
                            );
                      },
                      child: Text("Book Now"),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}