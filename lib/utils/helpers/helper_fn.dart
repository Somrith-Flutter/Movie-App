import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
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

