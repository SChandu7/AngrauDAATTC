import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class PdfScreen extends StatefulWidget {
  final String pdfPath; // asset or url
  final String title;

  PdfScreen({required this.pdfPath, required this.title});

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  bool isReady = false;
  String? localPath;
  int totalPages = 0;
  int currentPage = 0;

  Future<String> downloadFile(String url, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$fileName");

    if (await file.exists()) return file.path;

    await Dio().download(url, file.path);
    return file.path;
  }

  @override
  void initState() {
    super.initState();
    preparePDF();
  }

  preparePDF() async {
    if (widget.pdfPath.startsWith("http")) {
      // Network PDF download
      localPath = await downloadFile(widget.pdfPath, "${widget.title}.pdf");
    } else {
      // Local asset load
      final bytes = await rootBundle.load(widget.pdfPath);
      final buffer = bytes.buffer;
      Directory tempDir = await getTemporaryDirectory();
      final tempFile = File("${tempDir.path}/${widget.title}.pdf");

      await tempFile.writeAsBytes(
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
        flush: true,
      );

      localPath = tempFile.path;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          // Page indicator
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text("${currentPage + 1}/$totalPages"),
            ),
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              await Permission.storage.request();
              String savePath = localPath!;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("PDF downloaded to $savePath")),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              if (localPath != null) {
                await Share.shareXFiles([
                  XFile(localPath!),
                ], text: "Sharing PDF - ${widget.title}");
              }
            },
          ),
        ],
      ),
      body: localPath == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Hero(
                  tag: widget.title,
                  child: PDFView(
                    filePath: localPath!,
                    enableSwipe: true,
                    swipeHorizontal: false,
                    autoSpacing: false, // REMOVE SPACE
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
                if (!isReady) Center(child: CircularProgressIndicator()),
              ],
            ),
    );
  }
}
