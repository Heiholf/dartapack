import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

class Datapack {
  String name;
  String location;
  String description;
  int packFormat;

  String get _packRoot => path.join(location, name);
  String get _dataRoot => path.join(_packRoot, "data");
  String get _functionsRoot => path.join(_dataRoot, "test", "functions");

  Datapack({
    this.name = "Dartapack",
    this.packFormat = 18,
    this.location = "../",
    this.description = "A datapack created with dartapack",
  });

  /// Builds the entire Datapack
  void build() {
    _createMCMetaFile();
    _createFunctions();
  }

  /// Creates the functions directory and the corresponding files
  void _createFunctions() {
    Directory(_functionsRoot).create(recursive: true);
    File(path.join(_functionsRoot, 'test.mcfunction'))
        .create(recursive: true)
        .then((File file) {
      file.writeAsString("give @a minecraft:dirt");
    });
  }

  /// Creates `pack.mcmeta` and fills it
  void _createMCMetaFile() {
    String content = jsonEncode(
      {
        'pack': {
          'pack_format': packFormat,
          'description': description,
        },
      },
    );

    File(path.join(_packRoot, 'pack.mcmeta'))
        .create(recursive: true)
        .then((File file) {
      file.writeAsString(content);
    });
  }
}
