import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:legend_cinema/constants/api_path.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/core/model/fb_model.dart';
import 'package:legend_cinema/core/service/fb_from_service_model.dart';
import 'package:legend_cinema/core/service/rest_api_service.dart';
import 'package:http/http.dart' as http;

class FBRepository extends RestApiService {
  Future<List<FANDBModel>?> getLocationList() async {
    List<FANDBModel> fb = [];
    final String response = await getAssetData(ApiPath.locationlist);

    if (response.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(response);
      debugPrint(json.toString());
      for (var l in json['location']) {
        fb.add(FANDBModel.fromJson(l));
      }
      debugPrint(fb.toString());
      return fb;
    }
    return null;
  }

  Future<List<FBFromServiceModel>?> getDetailedDataRepo(String locationType) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('${AppConstant.domainKey}/api/f-n-b/v1/get-location-type'));
    request.body = json.encode({"location_type": locationType});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(body);
      return jsonResponse.map((data) => FBFromServiceModel.fromJson(data)).toList();
    } else {
      debugPrint(response.reasonPhrase);
    }
    return null;
  }
}
