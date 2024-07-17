import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_test/models/asset/asset.dart';

void main() {
  group('Asset Model Tests:', () {
    test('creation and property', () {
      final asset = Asset(
        name: 'Asset 1',
        id: '1',
        locationId: 'loc1',
        parentId: 'parent1',
        sensorType: 'sensor1',
        status: 'active',
      );

      expect(asset.name, 'Asset 1');
      expect(asset.id, '1');
      expect(asset.locationId, 'loc1');
      expect(asset.parentId, 'parent1');
      expect(asset.sensorType, 'sensor1');
      expect(asset.status, 'active');
      expect(asset.assets, isEmpty);
    });

    test('Asset.isComponent', () {
      final assetWithSensor = Asset(
        name: 'Asset 1',
        id: '1',
        sensorType: 'sensor1',
      );

      final assetWithoutSensor = Asset(
        name: 'Asset 2',
        id: '2',
      );

      expect(assetWithSensor.isComponent, isTrue);
      expect(assetWithoutSensor.isComponent, isFalse);
    });

    test('Asset.isUnlinked', () {
      final linkedAsset = Asset(
        name: 'Asset 1',
        id: '1',
        locationId: 'loc1',
      );

      final unlinkedAsset = Asset(
        name: 'Asset 2',
        id: '2',
      );

      expect(linkedAsset.isUnlinked, isFalse);
      expect(unlinkedAsset.isUnlinked, isTrue);
    });

    test('Asset.isEmpty', () {
      final assetWithSubAssets = Asset(
        name: 'Asset 1',
        id: '1',
        assets: [Asset(name: 'SubAsset 1', id: '1.1')],
      );

      final emptyAsset = Asset(
        name: 'Asset 2',
        id: '2',
      );

      expect(assetWithSubAssets.isEmpty, isFalse);
      expect(emptyAsset.isEmpty, isTrue);
    });
  });
}
