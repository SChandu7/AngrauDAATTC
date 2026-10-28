import 'package:angrauasr/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactService {
  static const String helplineNumber = '18004250430';
  static const String helplineDisplay = '1800 425 0430';
  static const String universityWebsite = 'https://angrau.ac.in';
  static const String privacyPolicyUrl =
      'https://api.chandus7.in/angraudaattc/privacy/';
  static const String supportUrl =
      'https://api.chandus7.in/angraudaattc/support/';

  /// Opens the phone dialer. iPads, iPods and phones without calling show
  /// the number instead.
  static Future<void> callHelpline(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: helplineNumber);
    final l10n = AppLocalizations.of(context)!;
    var launched = false;
    try {
      if (await canLaunchUrl(uri)) {
        launched = await launchUrl(uri);
      }
    } catch (_) {}
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.callNotAvailable(helplineDisplay))),
      );
    }
  }

  /// Opens a web page inside the app (Safari view on iPhone).
  static Future<void> openWebPage(String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }
}
