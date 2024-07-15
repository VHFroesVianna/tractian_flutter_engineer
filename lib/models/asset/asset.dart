import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

@unfreezed
class Asset with _$Asset {
  const Asset._();

  factory Asset({
    required final String name,
    required final String id,
    final String? locationId,
    final String? parentId,
    final String? sensorType,
    final String? status,
    @Default([]) List<Asset> assets,
  }) = _Asset;

  bool get isComponent => sensorType != null;

  bool get isUnlinked => locationId == null && parentId == null;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}
