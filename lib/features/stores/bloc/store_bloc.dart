import 'package:store/utilities/common_exports.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<StoreInitialEvent>((event, emit) => emit(LocalStoreInitial()));

    on<FetchRepositories>((event, emit) async {
      emit(StoreLoading());
      try {
        await DatabaseService().getDatabase();
        List<StoreModel> data = await ApiService().getStore();
        if (data.isNotEmpty) {
          emit(StoreLoaded(
              repositories: data, isRefreshed: event is FetchRepositories));
        } else {
          emit(const StoreError(message: "Data not found"));
        }
      } catch (e) {
        emit(StoreError(message: e.toString()));
      }
    });

    on<GetLocalStore>((event, emit) async {
      emit(LocalStoreLoading());
      try {
        List<StoreModel>? data = await DatabaseService().getAllStores();
        if (data != null) {
          emit(LocalStoreLoaded(repositories: data));
        } else {
          emit(const LocalStoreError(message: "Data not found"));
        }
      } catch (e) {
        emit(LocalStoreError(message: e.toString()));
      }
    });
  }
}
