import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:legend_cinema/constants/api_path.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/core/service/rest_api_service.dart';
import 'package:legend_cinema/modules/landings/home/model/home_model.dart';
import 'package:http/http.dart' as http;

class HomeRepository extends RestApiService {
  Future<List<MoiveModel>?> fetchMovieRepo({String? location, String? id}) async {
    List<MoiveModel> moive = [];
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('${AppConstant.domainKey}/${ApiPath.getMoive}'));
    request.body = json.encode({"location": location ?? ""});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      debugPrint(body);

      final json = jsonDecode(body);
      for(var result in json){
        if(result['id'] != id && result['location'] == location){
          moive.add(MoiveModel.fromJson(result)); 
        }else{
          moive.add(MoiveModel.fromJson(result)); 
        }
      }
      return moive;
    } else {
      debugPrint(response.reasonPhrase);
    }

    return null;
  }
}
