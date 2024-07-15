import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tractian_test/models/asset/asset.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@unfreezed
class Location with _$Location {
  Location._();

  factory Location({
    required final String name,
    required final String id,
    final String? parentId,
    @Default([]) List<Location> sublocations,
    @Default([]) List<Asset> assets,
  }) = _Location;

  bool get isTopLocation => parentId == null;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
