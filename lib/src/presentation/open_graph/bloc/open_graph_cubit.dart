// presentation/open_graph/bloc/open_graph_cubit.dart
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/entities/open_graph_entity.dart';
import 'package:stream_feed_unofficial/src/domain/open_graph/usecases/open_graph_usecase.dart';

part 'open_graph_state.dart';

class OpenGraphCubit extends Cubit<OpenGraphState> {
  OpenGraphCubit(this.fetchOpenGraphUsecase) : super(OpenGraphInitial());
  final FetchOpenGraphUsecase fetchOpenGraphUsecase;

  OpenGraphEntity? openGraphEntity;

  // Fetch Open Graph data for the detected URL
  Future<void> fetchOpenGraphData(String url) async {
    emit(OpenGraphLoading());
    try {
      final openGraphData = await fetchOpenGraphUsecase(url);
      if (openGraphData != null) {
        openGraphEntity = openGraphData;
        emit(OpenGraphPreviewFetched(openGraphData));
      }
    } catch (e) {
      emit(const OpenGraphError('Failed to fetch Open Graph data'));
    }
  }

  void removePreview() {
    openGraphEntity = null; // Reset the Open Graph data
    emit(OpenGraphRemoved());
  }
}
