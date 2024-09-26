// presentation/open_graph/bloc/open_graph_state.dart
part of 'open_graph_cubit.dart';

abstract class OpenGraphState extends Equatable {
  const OpenGraphState();

  @override
  List<Object?> get props => [];
}

class OpenGraphInitial extends OpenGraphState {}

class OpenGraphRemoved extends OpenGraphState {}

class OpenGraphLoading extends OpenGraphState {}

class OpenGraphPreviewFetched extends OpenGraphState {
  final OpenGraphEntity openGraphData;

  const OpenGraphPreviewFetched(this.openGraphData);

  @override
  List<Object?> get props => [openGraphData];
}

class OpenGraphError extends OpenGraphState {
  const OpenGraphError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
