import 'package:store/utilities/common_exports.dart';

class StoreListItem extends StatelessWidget {
  final StoreModel repository;

  const StoreListItem({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        repository.name,
        style: context.textTheme.titleMedium,
      ),
      subtitle: Text(repository.description),
      trailing: Text('${repository.stargazersCount} ⭐'),
    );
  }
}
