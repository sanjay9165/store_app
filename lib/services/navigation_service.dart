import 'package:store/utilities/common_exports.dart';

class Routes {
  static const String storeApp = '/';
  static const String localStore = '/localStore';
}

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.storeApp:
        return MaterialPageRoute(builder: (_) => const StoreScreen());
      case Routes.localStore:
        return MaterialPageRoute(builder: (_) => const LocalStore());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
