// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ANGRAU DAATTC';

  @override
  String get tagline => 'Crop production guides for farmers';

  @override
  String get cropGuides => 'Crop Guides';

  @override
  String get universityTollfree => 'University\nToll-free No.';

  @override
  String get searchHint => 'Search crops';

  @override
  String get noResults => 'No matching crops';

  @override
  String get selectCrop => 'Select a crop';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get about => 'About';

  @override
  String get loading => 'Loading...';

  @override
  String get preparingGuide => 'Preparing guide...';

  @override
  String downloadingPercent(int percent) {
    return 'Downloading $percent%';
  }

  @override
  String get loadFailed =>
      'Could not load this guide. Check your internet connection and try again.';

  @override
  String get retry => 'Try again';

  @override
  String get share => 'Share';

  @override
  String pageOf(int page, int total) {
    return '$page / $total';
  }

  @override
  String callNotAvailable(String number) {
    return 'Calling is not available on this device. Please call $number from a phone.';
  }

  @override
  String get aboutBody =>
      'ANGRAU DAATTC brings the crop production guides of Acharya N.G. Ranga Agricultural University to farmers in English and Telugu. Each guide covers varieties, sowing, nutrient, water, weed, pest and disease management for the crop.';

  @override
  String get offlineTitle => 'Offline reading';

  @override
  String offlineStatus(int saved, int total) {
    return '$saved of $total guides saved on this phone';
  }

  @override
  String get downloadAll => 'Download all guides';

  @override
  String get downloadingAll => 'Downloading guides...';

  @override
  String get allSaved =>
      'All guides are saved. You can read them without internet.';

  @override
  String get developedBy => 'Developed by';

  @override
  String get developerCredit =>
      'Dr. P.B. Pradeep Kumar\nSenior Scientist & Coordinator,\nDAATTC, Paderu, Alluri Sitharama Raju District\nAcharya N.G. Ranga Agricultural University, Guntur, A.P.';

  @override
  String get helpline => 'University toll-free helpline';

  @override
  String get universityWebsite => 'University website';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get contactSupport => 'Support';

  @override
  String version(String version) {
    return 'Version $version';
  }
}
