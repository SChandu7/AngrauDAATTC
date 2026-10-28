import 'dart:async';

import 'package:angrauasr/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../data/crop_catalog.dart';
import '../services/contact_service.dart';
import '../services/pdf_cache_service.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final List<String> _files = CropCatalog.allPdfFiles();
  int _saved = 0;
  bool _downloading = false;
  String _version = '';
  Timer? _refresh;

  @override
  void initState() {
    super.initState();
    _countSaved();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _version = info.version);
    }).catchError((_) {});
  }

  @override
  void dispose() {
    _refresh?.cancel();
    super.dispose();
  }

  Future<void> _countSaved() async {
    final saved = await PdfCacheService.countSaved(_files);
    if (mounted) setState(() => _saved = saved);
  }

  Future<void> _downloadAll() async {
    setState(() => _downloading = true);
    _refresh = Timer.periodic(const Duration(seconds: 1), (_) => _countSaved());
    await PdfCacheService.downloadAll(_files);
    _refresh?.cancel();
    await _countSaved();
    if (mounted) setState(() => _downloading = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final green = Colors.green.shade800;
    final allSaved = _saved >= _files.length;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.about)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Image.asset('assets/images/angrauicon.jpg', height: 110),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              l10n.appTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: green,
              ),
            ),
          ),
          if (_version.isNotEmpty)
            Center(
              child: Text(
                l10n.version(_version),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          const SizedBox(height: 16),
          Text(l10n.aboutBody, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.offlineTitle,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    allSaved
                        ? l10n.allSaved
                        : l10n.offlineStatus(_saved, _files.length),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: _files.isEmpty ? 0 : _saved / _files.length,
                    color: green,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  if (!allSaved) ...[
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _downloading ? null : _downloadAll,
                      icon: _downloading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.download_for_offline_outlined),
                      label: Text(
                        _downloading ? l10n.downloadingAll : l10n.downloadAll,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(l10n.helpline),
                  subtitle: const Text(ContactService.helplineDisplay),
                  onTap: () => ContactService.callHelpline(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.public),
                  title: Text(l10n.universityWebsite),
                  subtitle: const Text('angrau.ac.in'),
                  onTap: () => ContactService.openWebPage(
                    ContactService.universityWebsite,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: Text(l10n.privacyPolicy),
                  onTap: () => ContactService.openWebPage(
                    ContactService.privacyPolicyUrl,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: Text(l10n.contactSupport),
                  onTap: () =>
                      ContactService.openWebPage(ContactService.supportUrl),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            l10n.developedBy,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: green),
          ),
          const SizedBox(height: 6),
          Text(l10n.developerCredit, textAlign: TextAlign.center),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
