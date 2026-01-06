import 'package:flutter_test/flutter_test.dart';
import 'package:book_bridge_app/features/locations/domain/location_model.dart';

void main() {
  group('Location', () {
    test('fromJson/toJson', () {
      final location = Location(
        localityId: '1',
        name: 'Test Location',
        city: 'Test City',
      );
      final json = location.toJson();
      final newLocation = Location.fromJson(json);
      expect(newLocation.localityId, location.localityId);
      expect(newLocation.name, location.name);
    });
  });
}
