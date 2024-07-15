import 'package:get/get.dart';
import 'package:tractian_test/models/asset/asset.dart';
import 'package:tractian_test/models/data/data_loader.dart';
import 'package:tractian_test/models/location/location.dart';

class DataController extends GetxController {
  final String _locationsPath;
  final String _assetsPath;

  final _dataLoader = DataLoader();

  var locations = <Location>[].obs;

  var unlinkedAssets = <Asset>[].obs;

  var isLoading = false.obs;

  DataController({required String locationsPath, required String assetsPath})
      : _locationsPath = locationsPath,
        _assetsPath = assetsPath;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading(true);
    try {
      final allLocations =
          await _dataLoader.loadAndOrganizeData(_locationsPath, _assetsPath);
      locations(allLocations);
      final allUnlinkedAssets =
          await _dataLoader.loadUnlinkedAssets(_assetsPath);
      unlinkedAssets(allUnlinkedAssets);
    } catch (e) {
      Get.snackbar('Erro', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
