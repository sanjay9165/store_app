import 'package:store/utilities/common_exports.dart';

class LocalStore extends StatelessWidget {
  const LocalStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Local Store"),
        ),
        body: BlocConsumer<StoreBloc, StoreState>(
          listenWhen: (previous, current) {
            if (current is LocalStoreLoaded || current is LocalStoreError) {
              return true;
            }
            return false;
          },
          buildWhen: (previous, current) {
            if (current is LocalStoreInitial ||
                current is LocalStoreLoading ||
                current is LocalStoreLoaded) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state is LocalStoreError) {
              context.showAppSnackBar(title: state.message);
            }
          },
          builder: (context, state) {
            if (state is LocalStoreInitial) {
              context.read<StoreBloc>().add(GetLocalStore());
            }

            if (state is LocalStoreLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LocalStoreLoaded) {
              return ListView.builder(
                itemCount: state.repositories.length,
                itemBuilder: (context, index) {
                  return StoreListItem(repository: state.repositories[index]);
                },
              );
            }
            return const SizedBox();
          },
        ));
  }
}
