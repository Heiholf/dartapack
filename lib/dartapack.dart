/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

export 'src/base_old.dart';
export 'src/datapack.dart';

import 'package:build/build.dart';
import 'package:dartapack/src/generators/widget_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder widgetBuilder(BuilderOptions options) =>
    SharedPartBuilder([WidgetGenerator(options)], 'widgetBuilder');
