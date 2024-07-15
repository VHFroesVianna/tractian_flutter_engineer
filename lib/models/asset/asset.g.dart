// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssetImpl _$$AssetImplFromJson(Map<String, dynamic> json) => _$AssetImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      locationId: json['locationId'] as String?,
      parentId: json['parentId'] as String?,
      sensorType: json['sensorType'] as String?,
      status: json['status'] as String?,
      assets: (json['assets'] as List<dynamic>?)
              ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AssetImplToJson(_$AssetImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'locationId': instance.locationId,
      'parentId': instance.parentId,
      'sensorType': instance.sensorType,
      'status': instance.status,
      'assets': instance.assets,
    };
