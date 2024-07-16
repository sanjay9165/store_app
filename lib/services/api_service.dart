import 'package:flutter/foundation.dart';
import 'package:store/utilities/common_exports.dart';

class ApiService {
  factory ApiService() => _singleton;

  static final ApiService _singleton = ApiService._internal();
  late String _baseUrl;

  ApiService._internal();

  // Initialise Base URL
  Future<void> initialiseApiResource() async {
    await dotenv.load(fileName: ".env");
    _baseUrl = (dotenv.env['BASE_URL'] ?? "");
  }

  // FETCH STORE
  Future<List<StoreModel>> getStore() async {
    List<StoreModel> storeList = [];
    try {
      final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final String url =
          '$_baseUrl${ApiUrls.storeUrl}?q=created:$date&sort=stars&order=desc';
      log(url);
      final Response response = await url.toUri().httpGet();

      if (response.statusCode == 200) {
        final receivePort = ReceivePort();
        await Isolate.spawn(
            parseStoreLocalData, [receivePort.sendPort, response.body]);
        final message = await receivePort.first;
        if (message is List<StoreModel>) {
          storeList = message;
          // await insertBatchStore(storeList);
          await DatabaseService().insertStore(storeList);
        }
      }
    } catch (e) {
      log('ERROR ON GET STORE DATA: $e');
    }
    return storeList;
  }

  void parseStoreLocalData(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final String body = args[1];
    final Map<String, dynamic> data =
        body.castToJsonDecodeToMapOfStringDynamic();

    final List<Map<String, dynamic>> dataList =
        (data["items"] as List).castToListOfMapOfStringDynamic();
    List<StoreModel> stores =
        dataList.map((e) => StoreModel.fromJson(e)).toList();

    sendPort.send(stores);
  }

  Future<void> insertBatchStore(List<StoreModel> storeList) async {
    await compute(DatabaseService().insertStore, storeList);
  }
}
