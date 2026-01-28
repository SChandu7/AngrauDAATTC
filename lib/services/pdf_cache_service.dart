import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfCacheService {
  static const String baseUrl =
      'https://djangotestcase.s3.ap-south-1.amazonaws.com/angraudaattcpdfs/';

  static const String cacheFlag = 'pdfs_downloaded';

  static Future<Directory> _getPdfDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final pdfDir = Directory('${dir.path}/pdfs');
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }
    return pdfDir;
  }

  /// CHECK if file exists locally
  static Future<File> getLocalFile(String fileName) async {
    final dir = await _getPdfDir();
    return File('${dir.path}/$fileName');
  }

  /// DOWNLOAD with progress (for single PDF)
  static Future<File> downloadSingle(
    String fileName, {
    required Function(double progress) onProgress,
  }) async {
    final file = await getLocalFile(fileName);

    if (await file.exists()) return file;

    final url = '$baseUrl$fileName';

    await Dio().download(
      url,
      file.path,
      onReceiveProgress: (received, total) {
        if (total > 0) {
          onProgress(received / total);
        }
      },
    );

    return file;
  }

  /// BACKGROUND download ALL (NO UI blocking)
  static Future<void> downloadAllInBackground(
    List<String> files,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool(cacheFlag) ?? false;
    if (done) return;

    for (final file in files) {
      try {
        final f = await getLocalFile(file);
        if (!await f.exists()) {
          await Dio().download('$baseUrl$file', f.path);
        }
      } catch (_) {}
    }

    await prefs.setBool(cacheFlag, true);
  }
}
