import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import '../annotations.dart';
import 'package:source_gen/source_gen.dart';

class FieldsGenerator extends GeneratorForAnnotation<InpilotModel> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    print("Here");
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Inpilot model annotation can only be applied to classes.',
        element: element,
      );
    }

    final buffer = StringBuffer();

    // Iterate over the fields of the class and generate the params file content
    for (final field in element.fields) {
      final fieldName = field.name;
      final fieldType = field.type.toString();

      buffer.writeln('const $fieldName = "$fieldType";');
    }

    return buffer.toString();
  }
}
