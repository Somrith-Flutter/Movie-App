import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/api_path.dart';
import 'package:legend_cinema/core/model/fb_model.dart';
import 'package:legend_cinema/core/service/rest_api_service.dart';
import 'package:legend_cinema/modules/landings/f_b/model/f_b_model.dart';

class FBRepository extends RestApiService{
  Future<List<FANDBModel>?> getLocationList() async {
    List<FANDBModel> fb = [];
    final String response = await getAssetData(ApiPath.locationlist);

    if(response.isNotEmpty){
      var json = jsonDecode(response);
      for(var l in json['location']){
        fb.add(FANDBModel.fromJson(l));
      }
      return fb;
    }
    return null;
  }

   Future<FBModel> getDetailedData(String endpoint, String locationType) async {
    final Map<String, dynamic> data = {'location_type': locationType};
    final response = await postBody(endpoint, data);
    return FBModel.fromJson(json.decode(response)); 
  }
}
