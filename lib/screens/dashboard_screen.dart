import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/service/service_bloc.dart';
import '../blocs/service/service_event.dart';
import '../blocs/service/service_state.dart';
import '../repositories/service_repository.dart';
import 'detail_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceBloc(ServiceRepository())..add(FetchServices()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("QuickServe"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            )
          ],
        ),
        body: BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            if (state is ServiceLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ServiceLoaded) {
              return ListView.builder(
                itemCount: state.services.length,
                itemBuilder: (_, i) {
                  final s = state.services[i];

                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(s['name']),
                      subtitle: Text("₹${s['price']}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(service: s),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            if (state is ServiceError) {
              return Center(child: Text(state.message));
            }

            return Container();
          },
        ),
      ),
    );
  }
}