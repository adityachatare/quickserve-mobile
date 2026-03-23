abstract class ServiceEvent {}

class FetchServices extends ServiceEvent {}

class servicesUpdated extends ServiceEvent {
  final List services;
  servicesUpdated(this.services);
}