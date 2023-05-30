import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MasonParams {
  String name;
  List<Map<String, dynamic>> fields = [];

  MasonParams({
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "fields": fields,
      };
}
