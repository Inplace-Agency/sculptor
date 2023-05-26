import 'dart:convert';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:sculptor/src/models/mason_params.dart';
import '../annotations.dart';
import 'package:source_gen/source_gen.dart';

class FieldsGenerator extends GeneratorForAnnotation<MasonModel> {
  Map<String, dynamic> generateFieldMap(FieldElement element) {
    switch (element.name) {
      case "id":
        return {
          "fieldName": element.name,
          "id": true,
        };

      default:
        return {
          "fieldName": element.name,
          element.type.toString(): true,
        };
    }
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Inpilot model annotation can only be applied to classes.',
        element: element,
      );
    }

    MasonParams params = MasonParams(name: element.name);

    // Iterate over the fields of the class and generate the params file content
    for (final field in element.fields) {
      params.fields.add(generateFieldMap(field));
    }

    final buffer = StringBuffer();
    buffer.write(json.encode(params.toJson()));
    return buffer.toString();
  }
}
