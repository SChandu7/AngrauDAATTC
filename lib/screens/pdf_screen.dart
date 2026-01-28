import 'dart:io';
import 'package:angrauasr/services/pdf_cache_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class PdfScreen extends StatefulWidget {
  /// NOW this will be either:
  /// 1) full S3 URL
  /// 2) just filename like "andukorralu.pdf"
  final String pdfPath;
  final String title;

  const PdfScreen({required this.pdfPath, required this.title});

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  bool isReady = false;
  String? localPath;
  int totalPages = 0;
  int currentPage = 0;

  /// CHANGE THIS ONLY IF BUCKET PATH CHANGES
  static const String s3BaseUrl =
      'https://djangotestcase.s3.ap-south-1.amazonaws.com/angraudaattcpdfs/';

  /// App-private PDF directory
  Future<Directory> _getPdfDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final pdfDir = Directory('${dir.path}/pdfs');
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }
    return pdfDir;
  }

  /// Download only ONCE
  Future<String> _getOrDownloadPdf(String fileNameOrUrl) async {
    final pdfDir = await _getPdfDir();

    final fileName = fileNameOrUrl.startsWith('http')
        ? fileNameOrUrl.split('/').last
        : fileNameOrUrl;

    final file = File('${pdfDir.path}/$fileName');

    /// Already downloaded → use offline
    if (await file.exists()) {
      return file.path;
    }

    /// Build URL if only filename is provided
    final url = fileNameOrUrl.startsWith('http')
        ? fileNameOrUrl
        : '$s3BaseUrl$fileName';

    /// Download once
    await Dio().download(url, file.path);
    return file.path;
  }

  @override
  void initState() {
    super.initState();
    _preparePDF();
  }

  double _progress = 0.0;
  bool _downloading = false;

  Future<void> _preparePDF() async {
    final fileName = widget.pdfPath;

    final file = await PdfCacheService.getLocalFile(fileName);

    if (await file.exists()) {
      localPath = file.path;
      setState(() {});
      return;
    }

    // Not downloaded → download with progress
    setState(() {
      _downloading = true;
    });

    final downloadedFile = await PdfCacheService.downloadSingle(
      fileName,
      onProgress: (p) {
        setState(() => _progress = p);
      },
    );

    localPath = downloadedFile.path;

    setState(() {
      _downloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          /// Page indicator
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text('${currentPage + 1}/$totalPages'),
            ),
          ),

          /// Download button (already downloaded, but keeps UX)
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              await Permission.storage.request();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('PDF saved in app storage')),
              );
            },
          ),

          /// Share button
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              if (localPath != null) {
                await Share.shareXFiles([
                  XFile(localPath!),
                ], text: 'Sharing PDF - ${widget.title}');
              }
            },
          ),
        ],
      ),

      body: _downloading
          // 🔽 DOWNLOAD IN PROGRESS (NETWORK OR BACKGROUND)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(value: _progress),
                  const SizedBox(height: 12),
                  Text(
                    _progress == 0
                        ? 'Preparing download...'
                        : 'Downloading ${(100 * _progress).toInt()}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          // 📄 FILE READY BUT PDF NOT YET RENDERED
          : localPath == null
          ? const Center(child: CircularProgressIndicator())
          // ✅ PDF VIEW
          : Stack(
              children: [
                Hero(
                  tag: widget.title,
                  child: PDFView(
                    filePath: localPath!,
                    enableSwipe: true,
                    swipeHorizontal: false,
                    autoSpacing: false,
                    pageSnap: false,
                    nightMode: false,
                    onRender: (pages) {
                      setState(() {
                        totalPages = pages!;
                        isReady = true;
                      });
                    },
                    onPageChanged: (page, total) {
                      setState(() => currentPage = page!);
                    },
                  ),
                ),

                // ⏳ PDF RENDERING OVERLAY
                if (!isReady) const Center(child: CircularProgressIndicator()),
              ],
            ),
    );
  }
}
