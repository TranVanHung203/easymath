import '../models/chuc_donvi.dart';

abstract class ChucDonviApiService {
  Future<List<ChucDonvi>> fetchChucDonvi();
}

class ChucDonviMockService implements ChucDonviApiService {
  static const _mock = [
    {
      'name': 'Giỏ kẹo',
      'url':
          'https://res.cloudinary.com/dplq4inrc/image/upload/v1765511515/12_1_s2ithy.svg',
      'number': 10,
    },
    {
      'name': 'Kẹo',
      'url':
          'https://res.cloudinary.com/dplq4inrc/image/upload/v1765511485/123_2_mgzh2q.svg',
      'number': 5,
    },
  ];

  @override
  Future<List<ChucDonvi>> fetchChucDonvi() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return _mock.map(ChucDonvi.fromJson).toList();
  }
}
