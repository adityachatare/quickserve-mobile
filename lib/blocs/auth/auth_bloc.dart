import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo;

  AuthBloc(this.repo) : super(AuthInitial()) {

    on<LoginEvent>((event, emit) async {
      print("🔥 LOGIN EVENT TRIGGERED");

      emit(AuthLoading());

      try {
        print("📡 CALLING API...");
        await repo.login(event.email, event.password);

        print("✅ LOGIN SUCCESS");
        emit(AuthAuthenticated());

      } catch (e) {
        print("❌ LOGIN ERROR: $e");
        emit(AuthError("Login failed"));
      }
    });

    on<LogoutEvent>((event, emit) {
      print("🚪 LOGOUT");
      emit(AuthUnauthenticated());
    });
  }
}