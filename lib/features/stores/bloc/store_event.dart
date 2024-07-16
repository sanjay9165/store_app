import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class FetchRepositories extends StoreEvent {}

class GetLocalStore extends StoreEvent {}

class StoreInitialEvent extends StoreEvent {}
