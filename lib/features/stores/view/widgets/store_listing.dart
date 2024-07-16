import 'package:store/utilities/common_exports.dart';

class StoreListing extends StatelessWidget {
  const StoreListing({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreBloc, StoreState>(
      listenWhen: (previous, current) {
        if (current is StoreLoaded || current is StoreError) {
          return true;
        }
        return false;
      },
      buildWhen: (previous, current) {
        if (current is StoreInitial ||
            current is StoreLoaded ||
            current is StoreLoading) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state is StoreLoaded && state.isRefreshed) {
          context.showAppSnackBar(title: "Refreshed");
        }

        if (state is StoreError) {
          context.pop();
          context.showAppSnackBar(title: state.message);
        }
      },
      builder: (context, state) {
        if (state is StoreInitial) {
          context.read<StoreBloc>().add(FetchRepositories());
        }

        if (state is StoreLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is StoreLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<StoreBloc>().add(FetchRepositories());
            },
            child: ListView.builder(
              itemCount: state.repositories.length,
              itemBuilder: (context, index) {
                return StoreListItem(repository: state.repositories[index]);
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
