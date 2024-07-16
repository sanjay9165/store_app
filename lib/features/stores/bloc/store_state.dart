import 'package:store/features/stores/model/store_model.dart';
import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {}

class LocalStoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreModel> repositories;
  final bool isRefreshed;

  const StoreLoaded({required this.repositories, this.isRefreshed = false});

  @override
  List<Object> get props => [repositories, isRefreshed];
}

class StoreError extends StoreState {
  final String message;

  const StoreError({required this.message});

  @override
  List<Object> get props => [message];
}

class LocalStoreLoading extends StoreState {}

class LocalStoreLoaded extends StoreState {
  final List<StoreModel> repositories;

  const LocalStoreLoaded({required this.repositories});
}

class LocalStoreError extends StoreState {
  final String message;

  const LocalStoreError({required this.message});
}
