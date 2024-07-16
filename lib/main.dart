import 'package:store/utilities/common_exports.dart';

void main() async {
  await DatabaseService().initialiseApp();
  await DatabaseService().getDatabase();
  await ApiService().initialiseApiResource();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreBloc(),
      child: MaterialApp(
        title: 'Store',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().light,
        initialRoute: Routes.storeApp,
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: NavigationService.generateRoute,
      ),
    );
  }
}
