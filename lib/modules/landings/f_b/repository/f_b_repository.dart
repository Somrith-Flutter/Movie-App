import 'dart:convert';
import 'package:legend_cinema/constants/api_path.dart';
import 'package:legend_cinema/core/service/rest_api_service.dart';
import 'package:legend_cinema/modules/landings/f_b/model/f_b_model.dart';
import 'package:legend_cinema/modules/landings/f_b/model/location_model.dart';

class FBRepository extends RestApiService{
  Future<List<LocationModel>> getLocationList() async {
    final String response = await getAssetData(ApiPath.locationlist);
    final Map<String, dynamic> jsonResponse = json.decode(response);
    final List<dynamic> data = jsonResponse['location']; 
    return data.map((json) => LocationModel.fromJson(json)).toList();
  }

   Future<FBModel> getDetailedData(String endpoint, String locationType) async {
    final Map<String, dynamic> data = {'location_type': locationType};
    final response = await postBody(endpoint, data);
    return FBModel.fromJson(json.decode(response)); 
  }
}
