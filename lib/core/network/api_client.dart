import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_endpoints.dart';
import '../errors/app_exceptions.dart';

// http client wrapper
// even though firebase handles auth now, this is here for when
// i add a custom backend later - all http calls go through here

class ApiClient {
  ApiClient._(); // private constructor

  static final http.Client _client = http.Client();

  // -- headers --
  static Map<String, String> _headers({String? token}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // -- GET --
  static Future<dynamic> get(
    String endpoint, {
    String? token,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiEndpoints.baseUrl}$endpoint'),
        headers: _headers(token: token),
      );
      return _handleResponse(response);
    } on http.ClientException {
      throw const NetworkException(
        message: 'No internet connection. Please check your network.',
      );
    }
  }

  // -- POST --
  static Future<dynamic> post(
    String endpoint, {
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiEndpoints.baseUrl}$endpoint'),
        headers: _headers(token: token),
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } on http.ClientException {
      throw const NetworkException(
        message: 'No internet connection. Please check your network.',
      );
    }
  }

  // -- PUT --
  static Future<dynamic> put(
    String endpoint, {
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {
      final response = await _client.put(
        Uri.parse('${ApiEndpoints.baseUrl}$endpoint'),
        headers: _headers(token: token),
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } on http.ClientException {
      throw const NetworkException(
        message: 'No internet connection. Please check your network.',
      );
    }
  }

  // -- DELETE --
  static Future<dynamic> delete(
    String endpoint, {
    String? token,
  }) async {
    try {
      final response = await _client.delete(
        Uri.parse('${ApiEndpoints.baseUrl}$endpoint'),
        headers: _headers(token: token),
      );
      return _handleResponse(response);
    } on http.ClientException {
      throw const NetworkException(
        message: 'No internet connection. Please check your network.',
      );
    }
  }

  // -- response handler --
  // checks status code and throws the right exception
  static dynamic _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return body;
      case 400:
        throw AuthException(
          message: body['message'] ?? 'Bad request.',
          code: '400',
        );
      case 401:
        throw const AuthException(
          message: 'Session expired. Please log in again.',
          code: '401',
        );
      case 403:
        throw const PermissionException(
          message: 'You do not have permission to do this.',
          code: '403',
        );
      case 404:
        throw const NotFoundException(
          message: 'Resource not found.',
          code: '404',
        );
      case 500:
        throw const NetworkException(
          message: 'Server error. Please try again later.',
          code: '500',
        );
      default:
        throw const NetworkException(
          message: 'Something went wrong. Please try again.',
          code: 'unknown',
        );
    }
  }
}