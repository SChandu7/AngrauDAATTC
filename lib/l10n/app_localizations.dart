import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('te'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'ANGRAU DAATTC'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Crop production guides for farmers'**
  String get tagline;

  /// No description provided for @cropGuides.
  ///
  /// In en, this message translates to:
  /// **'Crop Guides'**
  String get cropGuides;

  /// No description provided for @universityTollfree.
  ///
  /// In en, this message translates to:
  /// **'University\nToll-free No.'**
  String get universityTollfree;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search crops'**
  String get searchHint;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No matching crops'**
  String get noResults;

  /// No description provided for @selectCrop.
  ///
  /// In en, this message translates to:
  /// **'Select a crop'**
  String get selectCrop;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @preparingGuide.
  ///
  /// In en, this message translates to:
  /// **'Preparing guide...'**
  String get preparingGuide;

  /// No description provided for @downloadingPercent.
  ///
  /// In en, this message translates to:
  /// **'Downloading {percent}%'**
  String downloadingPercent(int percent);

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load this guide. Check your internet connection and try again.'**
  String get loadFailed;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @pageOf.
  ///
  /// In en, this message translates to:
  /// **'{page} / {total}'**
  String pageOf(int page, int total);

  /// No description provided for @callNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Calling is not available on this device. Please call {number} from a phone.'**
  String callNotAvailable(String number);

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'ANGRAU DAATTC brings the crop production guides of Acharya N.G. Ranga Agricultural University to farmers in English and Telugu. Each guide covers varieties, sowing, nutrient, water, weed, pest and disease management for the crop.'**
  String get aboutBody;

  /// No description provided for @offlineTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline reading'**
  String get offlineTitle;

  /// No description provided for @offlineStatus.
  ///
  /// In en, this message translates to:
  /// **'{saved} of {total} guides saved on this phone'**
  String offlineStatus(int saved, int total);

  /// No description provided for @downloadAll.
  ///
  /// In en, this message translates to:
  /// **'Download all guides'**
  String get downloadAll;

  /// No description provided for @downloadingAll.
  ///
  /// In en, this message translates to:
  /// **'Downloading guides...'**
  String get downloadingAll;

  /// No description provided for @allSaved.
  ///
  /// In en, this message translates to:
  /// **'All guides are saved. You can read them without internet.'**
  String get allSaved;

  /// No description provided for @developedBy.
  ///
  /// In en, this message translates to:
  /// **'Developed by'**
  String get developedBy;

  /// No description provided for @developerCredit.
  ///
  /// In en, this message translates to:
  /// **'Dr. P.B. Pradeep Kumar\nSenior Scientist & Coordinator,\nDAATTC, Paderu, Alluri Sitharama Raju District\nAcharya N.G. Ranga Agricultural University, Guntur, A.P.'**
  String get developerCredit;

  /// No description provided for @helpline.
  ///
  /// In en, this message translates to:
  /// **'University toll-free helpline'**
  String get helpline;

  /// No description provided for @universityWebsite.
  ///
  /// In en, this message translates to:
  /// **'University website'**
  String get universityWebsite;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get contactSupport;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'te'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
