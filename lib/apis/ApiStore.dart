import 'package:dio/dio.dart';
import 'package:snab_budget/static_data.dart';

Dio httpClient() {
  final options = BaseOptions(
      baseUrl: 'https://snabbbudget.7skiessolutions.net/api/',
      headers: {"Content-Type": "application/json", ...getAuthHeader()});
  return Dio(options);
}

Dio httpFormDataClient() {
  final options = BaseOptions(
      baseUrl: 'https://snabbbudget.7skiessolutions.net/api/',
      headers: {"Content-Type": "multipart/form-data", ...getAuthHeader()});
  return Dio(options);
}

Map<String, String> getAuthHeader() {
  return {"Authorization": "Bearer ${StaticValues.token}"};
}
