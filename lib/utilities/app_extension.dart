import 'dart:convert';

import 'package:store/utilities/common_exports.dart';

extension BuildContextExtensions on BuildContext {
  // NAVIGATION METHODS
  void pop() => Navigator.of(this).pop();

  void mayBePop() async => await Navigator.of(this).maybePop();

  Future<dynamic> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.pushNamed(this, routeName, arguments: arguments);

  void popAndPushNamed(String routeName, {Object? arguments}) =>
      Navigator.popAndPushNamed(this, routeName, arguments: arguments);

  void pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.pushReplacementNamed(this, routeName, arguments: arguments);

  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(this, routeName, (route) => false,
          arguments: arguments);

  // TEXT THEME
  TextTheme get textTheme => Theme.of(this).textTheme;

  double getScreenHeight(double value) =>
      MediaQuery.of(this).size.height * value;

  double getScreenWidth(double value) => MediaQuery.of(this).size.width * value;

  Future<dynamic> showAppGeneralDialog({
    required Widget child,
    Color? barrierColor,
  }) async =>
      await showGeneralDialog(
        context: this,
        barrierColor: barrierColor ?? Colors.transparent.withOpacity(0.2),
        pageBuilder: (context, animation, secondaryAnimation) => child,
      );

  ScaffoldMessengerState get _scaffoldMessenger => ScaffoldMessenger.of(this);

  void hideSnackbar() => _scaffoldMessenger.hideCurrentSnackBar();

  void removeSnackbar() => _scaffoldMessenger.removeCurrentSnackBar();

  void showAppSnackBar(
      {required String title, Widget? leading, Widget? trailing}) {
    hideSnackbar();
    removeSnackbar();
    _scaffoldMessenger.showSnackBar(
      SnackBar(
        elevation: 8,
        showCloseIcon: false,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 500),
        backgroundColor: AppColors.nickel,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        content: Text(
          title,
          style: textTheme.displayMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

extension URIExtensions on Uri {
  Future<Response> httpPost({
    Map<String, String>? headers,
    Object? body,
  }) async =>
      await post(this, headers: headers, body: body);

  Future<Response> httpGet({
    Map<String, String>? headers,
  }) async =>
      await get(this, headers: headers);

  MultipartRequest multipartPost() => MultipartRequest('POST', this);
}

extension StringExtensions on String {
  Uri toUri() => Uri.parse(this);

  int toInt() => int.parse(this);

  num toNum() => num.parse(this);

  double toDouble() => double.parse(this);

  Map<String, dynamic> castToJsonDecodeToMapOfStringDynamic() =>
      (jsonDecode(toString()) as Map).castToMapOfStringDynamic();

  List<Map<String, dynamic>> castToJsonDecodeToListOfMapOfStringDynamic() =>
      (jsonDecode(toString()) as List<dynamic>)
          .castToListOfMapOfStringDynamic();

  dynamic castToJsonDecode() => jsonDecode(this);
}

extension MapParsing<T> on Map<T, T> {
  String castToJsonEncode() => jsonEncode(this);

  Map<String, dynamic> castToMapOfStringDynamic() => cast<String, dynamic>();

  void renameKey(T previousName, T newName) {
    final T previousData = this[previousName] as T;
    this[newName] = previousData;
    remove(previousName);
  }
}

extension AppListExtensions<E> on List<E> {
  List<Map<String, dynamic>> castToListOfMapOfStringDynamic() =>
      map((e) => e).toList().cast<Map<String, dynamic>>();
}

extension FormValidation on String {
  String get _emailPattern =>
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  bool get emailValidation => RegExp(_emailPattern).hasMatch(this);

  bool get isValidPassword => RegExp(
          r'^(?=(.*[a-z]){3,})(?=(.*[A-Z]){1,})(?=(.*[0-9]){2,})(?=(.*[!@#$%^&*()-__+.]){1,}).{8,}$')
      .hasMatch(this);

  bool get isValidPhone => RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(this);
}
