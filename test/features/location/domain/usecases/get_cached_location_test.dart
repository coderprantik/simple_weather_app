import 'package:flutter_test/flutter_test.dart';
import 'package:weatherple/features/location/usecases/get_cached_location.dart';

import 'get_current_location_test.mocks.dart';


void main() {
  late MockLocationRepository mockLocationRepository;
  late GetCachedLocation getCachedLocation;

  setUp(() {
    mockLocationRepository = MockLocationRepository();

    getCachedLocation = GetCachedLocation(repository: mockLocationRepository);
  });
}
