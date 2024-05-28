import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class Visitor extends SimpleElementVisitor<void> {
  String className = '';

  @override
  void visitConstructorElement(ConstructorElement element) {
    final String returnType = element.returnType.toString();

    className = returnType.replaceFirst("*", "");
  }
}
