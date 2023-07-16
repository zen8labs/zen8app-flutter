import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:rxdart/rxdart.dart';

class MultipartFileReusable extends MultipartFile {
  MultipartFileReusable(
    Stream<List<int>> stream,
    int length, {
    String? filename,
    MediaType? contentType,
    Map<String, List<String>>? headers,
  }) : super(
          stream,
          length,
          filename: filename,
          contentType: contentType,
          headers: headers,
        );

  static MultipartFileReusable fromFileSync(
    String filePath, {
    String? filename,
    MediaType? contentType,
    final Map<String, List<String>>? headers,
  }) {
    filename ??= p.basename(filePath);
    var file = File(filePath);
    var length = file.lengthSync();
    var stream = Rx.defer(() => file.openRead(), reusable: true);
    return MultipartFileReusable(
      stream,
      length,
      filename: filename,
      contentType: contentType,
      headers: headers,
    );
  }
}
