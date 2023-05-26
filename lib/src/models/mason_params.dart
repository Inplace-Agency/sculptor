import 'package:json_annotation/json_annotation.dart';

part 'mason_params.g.dart';

@JsonSerializable()
class MasonParams {
  String name;
  List<Map<String, dynamic>> fields;

  MasonParams({
    required this.name,
    this.fields = const [],
  });

  factory MasonParams.fromJson(Map<String, dynamic> json) => _$MasonParamsFromJson(json);
  Map<String, dynamic> toJson() => _$MasonParamsToJson(this);
}
