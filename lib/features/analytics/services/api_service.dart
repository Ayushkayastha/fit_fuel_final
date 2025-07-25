import 'package:dio/dio.dart';
import '../models/macro_entry_model.dart';
import '../models/step_entry_model.dart';

class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final dynamic data;

  ApiException({this.statusCode, required this.message, this.data});

  @override
  String toString() => 'ApiException: HTTP $statusCode — $message';
}

class ApiService {
  static const String baseUrl = 'https://ada93a08cb4d.ngrok-free.app';
  static final Dio _dio = Dio();

  /// Fetch macro breakdown; on 404 returns empty list.
  static Future<List<MacroEntry>> fetchMacroBreakdown(String userId, String date) async {
    final url = '$baseUrl/api/CalorieEntries/macro-breakdown/$userId?date=$date';
    print('⚙️  GET $url');
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((item) => MacroEntry.fromJson(item))
            .toList();
      }
      // any other non‑200 falls through to exception below
      throw ApiException(
        statusCode: response.statusCode,
        message: 'Unexpected response format',
        data: response.data,
      );
    } on DioError catch (e) {
      // If server says “not found”—i.e. no entries for that date—return empty.
      if (e.response?.statusCode == 404) {
        return <MacroEntry>[];
      }
      final resp = e.response;
      throw ApiException(
        statusCode: resp?.statusCode,
        message: resp?.data?.toString() ?? e.toString(),
        data: resp?.data,
      );
    }
  }

  /// Fetch last 7 days steps; on 404 returns empty list.
  static Future<List<StepEntry>> fetchLast7DaysSteps(String userId) async {
    final url = '$baseUrl/api/stepentry/last7days/$userId';
    print('⚙️  GET $url');
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((item) => StepEntry.fromJson(item))
            .toList();
      }
      throw ApiException(
        statusCode: response.statusCode,
        message: 'Unexpected response format',
        data: response.data,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return <StepEntry>[];
      }
      final resp = e.response;
      throw ApiException(
        statusCode: resp?.statusCode,
        message: resp?.data?.toString() ?? e.toString(),
        data: resp?.data,
      );
    }
  }
}
