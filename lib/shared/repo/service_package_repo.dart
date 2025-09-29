import 'package:garage/core/const/app_url.dart';
import 'package:garage/data/models/service_package.dart';
import 'package:garage/shared/services/network/api_client.dart';
import 'package:garage/utils/extension/object.dart';

class ServicePackageRepo {
  final _client = ApiClient();

  Future<ServicePackagesResponse?> getNearbyServices({
    required double lat,
    required double lng,
    int page = 1,
  }) async {
    try {
      final uri = Uri.parse('${AppUrl.baseUrl}${AppUrl.packages}')
          .replace(queryParameters: {
        'lat': lat.toString(),
        'lng': lng.toString(),
        'page': page.toString(),
      });

      final response = await _client.dio.getUri<Map<String, dynamic>>(uri);

      if (response.data != null &&
          response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return ServicePackagesResponse.fromJson(response.data!);
      } else {
        response.statusCode?.doPrint(prefix: 'Get nearby services failed: ');
        return null;
      }
    } on Exception catch (e) {
      e.doPrint(prefix: 'Get nearby services failed: ');
      return null;
    }
  }
}