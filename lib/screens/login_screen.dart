import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart' as authBloc;
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart' as authState;
import '../repositories/auth_repository.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => authBloc.AuthBloc(AuthRepository()),
      child: Scaffold(
        appBar: AppBar(title: Text("QuickServe Login")),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: BlocConsumer<authBloc.AuthBloc, authState.AuthState>(
            listener: (context, state) {
              if (state is authState.AuthAuthenticated) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => DashboardScreen()),
                );
              }

              if (state is authState.AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('')));
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  TextField(controller: email, decoration: InputDecoration(labelText: "Email")),
                  TextField(controller: password, decoration: InputDecoration(labelText: "Password")),
                  SizedBox(height: 20),

                  if (state is authState.AuthLoading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: () {
                    // context.read<authBloc.AuthBloc>().login(email.text, password.text);

                               context.read<authBloc.AuthBloc>().add(
                              LoginEvent(email.text, password.text),
                            );
                      },
                      child: Text("Login"),
                    ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                      );
                    },
                    child: Text("Create Account"),
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