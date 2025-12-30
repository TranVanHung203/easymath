import '../models/chuc_donvi.dart';
import '../services/chuc_donvi_api_service.dart';

class ChucDonviRepository {
  final ChucDonviApiService service;

  ChucDonviRepository(this.service);

  Future<List<ChucDonvi>> getAll() => service.fetchChucDonvi();
}
