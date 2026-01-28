import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfZipService {
  static const zipUrl =
      'https://djangotestcase.s3.ap-south-1.amazonaws.com/angraudaattcpdfs/angraudaattcallpdfs.zip';

  static const zipFlag = 'pdf_zip_downloaded';

  static Future<Directory> _getPdfDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final pdfDir = Directory('${dir.path}/pdfs');
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }
    return pdfDir;
  }

  static Future<void> downloadAndExtract({
  required Function(double progress) onProgress,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final done = prefs.getBool(zipFlag) ?? false;
  if (done) return;

  final dir = await getApplicationDocumentsDirectory();
  final zipFile = File('${dir.path}/pdfs.zip');

  /// Download ZIP
  await Dio().download(
    zipUrl,
    zipFile.path,
    onReceiveProgress: (rec, total) {
      if (total > 0) onProgress(rec / total);
    },
  );

  /// Extract ZIP
  final bytes = zipFile.readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);

  final pdfDir = await _getPdfDir();

  for (final file in archive) {
    if (file.isFile) {
      final outFile =
          File('${pdfDir.path}/${file.name.split('/').last}');

      // ✅ DO NOT overwrite already-downloaded files
      if (await outFile.exists()) {
        continue;
      }

      outFile
        ..createSync(recursive: true)
        ..writeAsBytesSync(file.content as List<int>);
    }
  }

  await prefs.setBool(zipFlag, true);

  /// Optional: delete zip after extract
  await zipFile.delete();
}

}
