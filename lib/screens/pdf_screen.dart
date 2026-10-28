import 'package:angrauasr/l10n/app_localizations.dart';
import 'package:angrauasr/services/pdf_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class PdfScreen extends StatefulWidget {
  /// File name of the guide on the server, like "andukorralu.pdf".
  final String pdfPath;
  final String title;

  const PdfScreen({super.key, required this.pdfPath, required this.title});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  String? localPath;
  bool isReady = false;
  bool _failed = false;
  bool _downloading = false;
  double _progress = 0.0;
  int totalPages = 0;
  int currentPage = 0;

  final GlobalKey _shareButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _preparePDF();
  }

  Future<void> _preparePDF() async {
    setState(() {
      _failed = false;
      _progress = 0;
    });

    try {
      final file = await PdfCacheService.getLocalFile(widget.pdfPath);
      if (await file.exists()) {
        if (mounted) setState(() => localPath = file.path);
        return;
      }

      if (mounted) setState(() => _downloading = true);

      final downloadedFile = await PdfCacheService.downloadSingle(
        widget.pdfPath,
        onProgress: (p) {
          if (mounted) setState(() => _progress = p);
        },
      );

      if (mounted) {
        setState(() {
          localPath = downloadedFile.path;
          _downloading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _downloading = false;
          _failed = true;
        });
      }
    }
  }

  /// A file that downloaded but cannot be opened is deleted, so "Try again"
  /// fetches a fresh copy.
  Future<void> _onRenderError() async {
    try {
      final file = await PdfCacheService.getLocalFile(widget.pdfPath);
      if (await file.exists()) await file.delete();
    } catch (_) {}
    if (mounted) {
      setState(() {
        localPath = null;
        _failed = true;
      });
    }
  }

  Future<void> _share() async {
    if (localPath == null) return;
    // iPad shows the share sheet as a popover anchored to the button.
    final box =
        _shareButtonKey.currentContext?.findRenderObject() as RenderBox?;
    await Share.shareXFiles(
      [XFile(localPath!, mimeType: 'application/pdf')],
      text: widget.title,
      sharePositionOrigin: box == null
          ? null
          : box.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (isReady && totalPages > 0)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(l10n.pageOf(currentPage + 1, totalPages)),
              ),
            ),
          IconButton(
            key: _shareButtonKey,
            tooltip: l10n.share,
            icon: Icon(Icons.adaptive.share),
            onPressed: localPath == null ? null : _share,
          ),
        ],
      ),
      body: _buildBody(l10n),
    );
  }

  Widget _buildBody(AppLocalizations l10n) {
    if (_failed) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 56, color: Colors.grey),
              const SizedBox(height: 12),
              Text(
                l10n.loadFailed,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _preparePDF,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (_downloading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(value: _progress == 0 ? null : _progress),
            const SizedBox(height: 12),
            Text(
              _progress == 0
                  ? l10n.preparingGuide
                  : l10n.downloadingPercent((100 * _progress).toInt()),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }

    if (localPath == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        PDFView(
          filePath: localPath!,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: false,
          pageSnap: false,
          nightMode: false,
          onRender: (pages) {
            if (!mounted) return;
            setState(() {
              totalPages = pages ?? 0;
              isReady = true;
            });
          },
          onPageChanged: (page, total) {
            if (!mounted) return;
            setState(() {
              currentPage = page ?? 0;
              totalPages = total ?? totalPages;
            });
          },
          onError: (_) => _onRenderError(),
        ),
        if (!isReady) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
