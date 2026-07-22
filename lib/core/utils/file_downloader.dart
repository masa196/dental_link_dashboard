import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;

class FileDownloader {
  static void downloadPng(
    Uint8List bytes, {
    required String fileName,
  }) {
    final blob = html.Blob([bytes], 'image/png');

    final url = html.Url.createObjectUrlFromBlob(blob);

    // ignore: unused_local_variable
    final anchor = html.AnchorElement(href: url)
      ..download = fileName
      ..click();

    html.Url.revokeObjectUrl(url);
  }
}