import 'dart:convert';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:sculptor/src/models/mason_params.dart';
import '../annotations.dart';
import 'package:source_gen/source_gen.dart';

class Sculptor extends GeneratorForAnnotation<MasonModel> {
  bool isDartCoreType(DartType type) {
    return type.isDartCoreList ||
        type.isDartCoreMap ||
        type.isDartCoreString ||
        type.isDartCoreInt ||
        type.isDartCoreDouble ||
        type.isDartCoreBool;
  }

  Map<String, dynamic> generateFieldMap(FieldElement element) {
    String type = element.type.getDisplayString(withNullability: false);
    bool isNullable = element.type.nullabilitySuffix == NullabilitySuffix.question;
    bool isEnum = element.type.element!.kind == ElementKind.ENUM;
    bool isClass = !isDartCoreType(element.type) && !isEnum && type != "DateTime";

    if (element.name == "id") {
      type = "id";
    }

    return {
      "fieldName": element.name,
      type: true,
      "nullable": isNullable,
      "enum": isEnum,
      "typeName": type,
      "isClass": isClass,
    };
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Mason model annotation can only be applied to classes.',
        element: element,
      );
    }

    MasonParams params = MasonParams(name: element.name);

    // Iterate over the fields of the class and generate the params file content
    for (final field in element.fields) {
      params.fields.add(generateFieldMap(field));
    }

    return json.encode(params.toJson());
  }
}
