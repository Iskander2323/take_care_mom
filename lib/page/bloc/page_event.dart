part of 'page_bloc.dart';

sealed class PageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PageFetched extends PageEvent {
  PageFetched(this.id);
  final String id;
}
