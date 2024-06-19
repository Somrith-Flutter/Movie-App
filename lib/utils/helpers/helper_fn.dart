import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:share_plus/share_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

Future<String> shareNetworkImage(String imageUrl) async {
  debugPrint(imageUrl);
  try {
    Dio dio = Dio();
    var response = await dio.get(imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file = File('$tempPath/movie.jpg');
      debugPrint("$file");
      file.writeAsBytesSync(response.data);
      // ignore: deprecated_member_use
      await Share.shareFiles([file.path], text: 'Check out this image!');
    } else {
      throw Exception('Failed to load image from network. Status code: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error sharing image: $e');
    }
  }
  return "";
}

Future<String> fetchImageWithRetry(String url, {int retries = 3}) async {
  int attempt = 0;
  while (attempt < retries) {
    try {
      final response = await HttpClient().getUrl(Uri.parse(url)).then((request) => request.close());
      if (response.statusCode == 200) {
        return url;
      } else {
        throw HttpException('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      attempt++;
      if (attempt >= retries) {
        rethrow;
      }
      await Future.delayed(const Duration(seconds: 2)); // Wait before retrying
    }
  }
  return "";
}

