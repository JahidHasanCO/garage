import 'package:garage/core/const/app_url.dart';
import 'package:garage/data/response/nearby_garage_list_response.dart';
import 'package:garage/shared/services/network/api_client.dart';
import 'package:garage/utils/extension/object.dart';

class GarageRepo {
  final _client = ApiClient();

  Future<NearbyGarageListResponse?> getNearbyGarages({
    required double lat,
    required double lng,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final uri = Uri.parse(AppUrl.garagesNearby).replace(
        queryParameters: {
          'lat': lat.toString(),
          'lng': lng.toString(),
          'page': page.toString(),
          'limit': limit.toString(),
        },
      );

      final response = await _client.dio.getUri<Map<String, dynamic>>(uri);

      if (response.data != null &&
          response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return NearbyGarageListResponse.fromJson(response.data!);
      } else {
        response.statusCode?.doPrint(prefix: 'Get nearby garages failed: ');
        return null;
      }
    } on Exception catch (e) {
      e.doPrint(prefix: 'Get nearby garages failed: ');
      return null;
    }
  }
}
