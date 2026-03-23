import 'package:flutter_bloc/flutter_bloc.dart';
import 'service_event.dart';
import 'service_state.dart';
import '../../repositories/service_repository.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository repo;

  ServiceBloc(this.repo) : super(ServiceInitial()) {
    on<FetchServices>((event, emit) async {
      emit(ServiceLoading());

      repo.startFetching();

      repo.servicesStream.listen(
        (data) {
          add(_ServicesUpdated(data));
        },
        onError: (error) {
          add(_ServiceErrorEvent(error.toString()));
        },
      );
    });

    on<_ServicesUpdated>((event, emit) {
      emit(ServiceLoaded(event.services));
    });

    on<_ServiceErrorEvent>((event, emit) {
      emit(ServiceError(event.message));
    });
  }

  @override
  Future<void> close() {
    repo.dispose();
    return super.close();
  }
}

class _ServicesUpdated extends ServiceEvent {
  final List services;
  _ServicesUpdated(this.services);
}

class _ServiceErrorEvent extends ServiceEvent {
  final String message;
  _ServiceErrorEvent(this.message);
}
