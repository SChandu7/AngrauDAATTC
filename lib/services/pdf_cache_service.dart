import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

/// Downloads the crop guide PDFs once and keeps them in the app's documents
/// folder, so every guide opened once (or fetched by the background download)
/// can be read offline afterwards.
class PdfCacheService {
  static const String baseUrl =
      'https://api.chandus7.in/media/angraudaattcpdfs/';

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(minutes: 2),
    ),
  );

  static Future<void>? _downloadAll;

  static Future<Directory> _getPdfDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final pdfDir = Directory('${dir.path}/pdfs');
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }
    return pdfDir;
  }

  static Future<File> getLocalFile(String fileName) async {
    final dir = await _getPdfDir();
    return File('${dir.path}/$fileName');
  }

  static Future<bool> isSaved(String fileName) async =>
      (await getLocalFile(fileName)).exists();

  /// Downloads one PDF. It is written to a ".part" file first and renamed
  /// when complete, so an interrupted download never leaves a broken PDF
  /// that would look like it was already saved.
  ///
  /// If the same file is already downloading (for example by the background
  /// download), that download is shared; `onProgress` is then not called.
  static Future<File> downloadSingle(
    String fileName, {
    void Function(double progress)? onProgress,
  }) {
    return _inFlight[fileName] ??= _download(fileName, onProgress).whenComplete(
      () => _inFlight.remove(fileName),
    );
  }

  static final Map<String, Future<File>> _inFlight = {};

  static Future<File> _download(
    String fileName,
    void Function(double progress)? onProgress,
  ) async {
    final file = await getLocalFile(fileName);
    if (await file.exists()) return file;

    final part = File('${file.path}.part');
    try {
      await _dio.download(
        '$baseUrl${Uri.encodeComponent(fileName)}',
        part.path,
        onReceiveProgress: (received, total) {
          if (total > 0 && onProgress != null) onProgress(received / total);
        },
      );
      return await part.rename(file.path);
    } catch (_) {
      if (await part.exists()) await part.delete();
      rethrow;
    }
  }

  static Future<int> countSaved(List<String> files) async {
    var saved = 0;
    for (final f in files) {
      if (await isSaved(f)) saved++;
    }
    return saved;
  }

  /// Downloads every missing PDF one after another. Failed files are skipped
  /// and fetched again next time. Calling it while a run is in progress
  /// returns that run instead of starting a second one.
  static Future<void> downloadAll(
    List<String> files, {
    void Function()? onFileSaved,
  }) {
    return _downloadAll ??= () async {
      try {
        for (final f in files) {
          try {
            if (!await isSaved(f)) {
              await downloadSingle(f);
              onFileSaved?.call();
            }
          } catch (_) {}
        }
      } finally {
        _downloadAll = null;
      }
    }();
  }
}
