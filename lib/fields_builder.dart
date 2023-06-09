import 'src/fields_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

class FieldBuilder extends LibraryBuilder {
  FieldBuilder() : super(Sculptor(), generatedExtension: '.hjson', header: "", formatOutput: (code) => code);
}

Builder fieldBuilder(BuilderOptions options) {
  return FieldBuilder(); // Return an instance of your custom builder
}
