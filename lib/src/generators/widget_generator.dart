import 'dart:async';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dartapack/src/base/format_widget.dart';
import 'package:dartapack/src/generators/visitor.dart';
import 'package:path/path.dart';
import 'package:source_gen/source_gen.dart';

import 'package:build/build.dart';

class WidgetGenerator extends GeneratorForAnnotation<FormatWidget> {
  const WidgetGenerator(this.options);
  final BuilderOptions options;

  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final String name = annotation.read("name").stringValue;
    final int minFormat = annotation.read("minFormat").intValue;
    final int maxFormat = annotation.read("maxFormat").intValue;

    int packFormat = options.config["format"];

    if (!(minFormat <= packFormat && packFormat <= maxFormat)) {
      return "";
    }

    final Visitor visitor = Visitor();
    element.visitChildren(visitor);
    final String className = visitor.className;

    if (name == className) {
      throw ArgumentError.value(name, "WidgetGenerator (name)");
    }

    AstNode? astNode = await buildStep.resolver.astNodeFor(element);
    String? sourceCode = astNode?.toString();

    List<String>? split = sourceCode?.split(")");
    split?.replaceRange(0, 1, []);
    String? body = split?.join(")");

    String? replaced = body?.replaceAll(className, name);

    final StringBuffer stringBuffer = StringBuffer();

    //stringBuffer.write("part '${buildStep.inputId.path.split("/").last}';");
    stringBuffer.write("part 'give.g.dart';");
    if (element.documentationComment != null) {
      stringBuffer.write("///${element.documentationComment}\n");
    }
    stringBuffer.write(replaced);

    return stringBuffer.toString();
  }
}
