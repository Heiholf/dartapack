import 'package:dartapack/src/widget.dart';
import 'format_widget.dart';

part 'give.widgetBuilder.g.part';

@FormatWidget("Give", minFormat: 20)
class GiveGreater20 extends Widget {
  @override
  String compile() {
    return "give @a minecraft:dirt 20";
  }
}

@FormatWidget("Give", maxFormat: 19)
class GiveLess20 extends Widget {
  @override
  String compile() {
    return "give @a minecraft:dirt 30";
  }
}
