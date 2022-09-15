import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:exceed_resources_frontend/app/modules/core/utils/enum.dart';
import 'package:path_provider/path_provider.dart';

Future<dynamic> request({
  dynamic body,
  required Function({String? error, String? type}) onError,
  required Function(List<dynamic>? data) onSuccess,
  required List<String> paths,
  required ERequestMethod method,
  Map<String, dynamic>? query,
  bool useCookie = true,
  String? errorType,
}) async {
  final Dio client = Dio();
  try {
    client.options.baseUrl = 'http://localhost:4000/';
    client.options.connectTimeout = 15000;
    client.options.receiveTimeout = 60000;

    if (query != null) {
      client.options.queryParameters = query;
    }

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final cj = PersistCookieJar(
      storage: FileStorage('$appDocPath/.cookies/'),
    );
    client.interceptors.add(
      CookieManager(cj),
    );

    final List<Map> responses = [];

    for (final path in paths) {
      switch (method) {
        case ERequestMethod.get:
          final response = await client.get(path);
          responses.add(response.data);
          break;
        case ERequestMethod.post:
          final response = await client.post(path, data: body);
          responses.add(response.data);
          break;
        case ERequestMethod.patch:
          final response = await client.patch(path, data: body);
          responses.add(response.data);
          break;
        case ERequestMethod.delete:
          final response = await client.delete(path, data: body);
          responses.add(response.data);
          break;
      }
    }
    onSuccess(responses);
  } catch (e) {
    final errResponse = (e as DioError).response?.data;
    if (errResponse == null) {
      onError(error: e.error is String ? e.error : e.error.message, type: errorType);
    } else if (errResponse['type'] != null) {
      onError(error: errResponse['message'], type: 'token');
    } else {
      onError(error: errResponse['message'], type: errorType);
    }
  } finally {
    client.close();
  }
}
