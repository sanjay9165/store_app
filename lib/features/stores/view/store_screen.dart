import 'package:store/utilities/common_exports.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Store App"),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(Routes.localStore);
                context.read<StoreBloc>().add(StoreInitialEvent());
              },
              icon: const Icon(Icons.cloud_off))
        ],
      ),
      body: const StoreListing(),
    );
  }
}
