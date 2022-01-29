import 'dart:io';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:image/image.dart' as img;

class ImageHelper {
  static String blur(File file) {
    final data = file.readAsBytesSync();
    final image = img.decodeImage(data.toList());
    final blurHash = BlurHash.encode(image!, numCompX: 4, numCompY: 3);
    return blurHash.hash;
  }
}
