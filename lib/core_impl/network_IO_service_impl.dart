import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../core/error/exceptions.dart';
import '../core/network/network_info.dart';
import '../core/network/network_io_service.dart';

class NetworkIOServiceImpl implements NetworkIOService {
  final http.Client client;
  final NetworkInfo networkInfo;

  NetworkIOServiceImpl({required this.client, required this.networkInfo});

  @override
  Future<String> get(String url,
      {Map<String, String> queryParams = const {},
      Map<String, String> headers = const {'Content-Type': 'application/json'}}) async {
    if (!(await networkInfo.isConnected)) {
      throw NoInternetError();
    }

    String queryString = '';
    if (queryParams.isNotEmpty) {
      Map<String, String> parsedQueryParameters = Uri.parse(url).queryParameters;
      queryParams.addAll(parsedQueryParameters);
      queryString = Uri(queryParameters: queryParams).query;
    }

    final response = await client.get(
      Uri.parse(queryParams.isNotEmpty ? "$url?$queryString" : url));

    debugPrint("Network HttpCode: ${response.statusCode}");
    debugPrint("Network ResponseBody: ${response.body}");

    if (response.statusCode == HttpStatus.ok) {
      return utf8.decode(response.bodyBytes);   //to escape special chars
    } else {
      if (response.statusCode == HttpStatus.unauthorized || response.statusCode == HttpStatus.forbidden) {
        return throw InvalidTokenError();
      }
      return throw BackendHardError(response.statusCode, "Something went wrong please try again.");
    }
  }

  @override
  Future<String> post(String url,
      {String requestData = "", Map<String, String> headers = const {'Content-Type': 'application/json'}}) async {
    if (!(await networkInfo.isConnected)) {
      throw NoInternetError();
    }

    debugPrint("Network URL :$url");
    debugPrint("Network Request :$requestData");

    final response = await client.post(Uri.parse(url), body: requestData);

    debugPrint("Network HttpCode: ${response.statusCode}");
    debugPrint("Network ResponseBody: ${response.body}");

    if (response.statusCode == HttpStatus.ok) {
      return utf8.decode(response.bodyBytes);   //to escape special chars
    } else {
      if (response.statusCode == HttpStatus.unauthorized || response.statusCode == HttpStatus.forbidden) {
        return throw InvalidTokenError();
      }
      return throw BackendHardError(response.statusCode, "Something went wrong please try again.");
    }
  }

  // Map<String, String> _addUserTokenHeader(Map<String, String> headers) {
  //   if (userData == null) return headers;
  //
  //   Map<String, String> tempHeader = {'Auth-Token': userData!.token, 'Device-Type': 'mobile'};
  //   tempHeader.addEntries(headers.entries);
  //   return tempHeader;
  // }
}
