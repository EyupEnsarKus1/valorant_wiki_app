import 'package:valorant_wiki_app/core/api_service.dart';
import 'package:valorant_wiki_app/core/constants/app_constants.dart';
import 'package:valorant_wiki_app/models/competitive_tier_data.dart';
import 'package:valorant_wiki_app/repositories/generic_repo.dart';

class CompetitiveTierRepository implements IGenericRepo<CompetitiveTierData> {
  final ApiService apiService = ApiService(baseUrl: AppConstants.baseUrl);

  @override
  Future<List<CompetitiveTierData>> getAllData() async {
    final ApiResponse<List<CompetitiveTierData>?> response =
        await apiService.get<List<CompetitiveTierData>>(
      Params.competitivetiers.name,
      (data) => (data['data'] as List)
          .map((tier) =>
              CompetitiveTierData.fromJson(tier as Map<String, dynamic>))
          .toList(),
    );

    if (response.type == ResponseType.success && response.data != null) {
      return response.data!;
    } else {
      throw Exception('Failed to load tiers data');
    }
  }

  @override
  Future<CompetitiveTierData> getDataById(String id) async {
    final ApiResponse<CompetitiveTierData?> response =
        await apiService.get<CompetitiveTierData>(
      '${Params.competitivetiers.name}/$id',
      (data) => CompetitiveTierData.fromJson(data as Map<String, dynamic>),
    );

    if (response.type == ResponseType.success && response.data != null) {
      return response.data!;
    } else {
      throw Exception('Failed to load tiers data');
    }
  }
}
