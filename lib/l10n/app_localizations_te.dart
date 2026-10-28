// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'ANGRAU DAATTC';

  @override
  String get tagline => 'రైతుల కోసం పంటల సాగు మార్గదర్శకాలు';

  @override
  String get cropGuides => 'పంటల మార్గదర్శకాలు';

  @override
  String get universityTollfree => 'యూనివర్సిటీ\nటోల్ ఫ్రీ నంబర్';

  @override
  String get searchHint => 'పంటలను వెతకండి';

  @override
  String get noResults => 'సరిపోలే పంటలు లేవు';

  @override
  String get selectCrop => 'పంటను ఎంచుకోండి';

  @override
  String get cancel => 'రద్దు చేయండి';

  @override
  String get close => 'మూసివేయండి';

  @override
  String get about => 'గురించి';

  @override
  String get loading => 'లోడ్ అవుతోంది...';

  @override
  String get preparingGuide => 'మార్గదర్శకం సిద్ధమవుతోంది...';

  @override
  String downloadingPercent(int percent) {
    return 'డౌన్‌లోడ్ అవుతోంది $percent%';
  }

  @override
  String get loadFailed =>
      'ఈ మార్గదర్శకాన్ని లోడ్ చేయలేకపోయాము. మీ ఇంటర్నెట్ కనెక్షన్‌ను తనిఖీ చేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get retry => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get share => 'షేర్ చేయండి';

  @override
  String pageOf(int page, int total) {
    return '$page / $total';
  }

  @override
  String callNotAvailable(String number) {
    return 'ఈ పరికరంలో కాల్ చేసే సౌకర్యం లేదు. దయచేసి ఫోన్ నుండి $number కు కాల్ చేయండి.';
  }

  @override
  String get aboutBody =>
      'ఆచార్య ఎన్.జి. రంగా వ్యవసాయ విశ్వవిద్యాలయం రూపొందించిన పంటల సాగు మార్గదర్శకాలను ANGRAU DAATTC రైతులకు తెలుగు మరియు ఇంగ్లీష్‌లో అందిస్తుంది. ప్రతి మార్గదర్శకంలో రకాలు, విత్తడం, ఎరువులు, నీటి యాజమాన్యం, కలుపు, పురుగులు మరియు తెగుళ్ల నివారణ వివరాలు ఉంటాయి.';

  @override
  String get offlineTitle => 'ఇంటర్నెట్ లేకుండా చదవడం';

  @override
  String offlineStatus(int saved, int total) {
    return '$total లో $saved మార్గదర్శకాలు ఈ ఫోన్‌లో సేవ్ అయ్యాయి';
  }

  @override
  String get downloadAll => 'అన్ని మార్గదర్శకాలను డౌన్‌లోడ్ చేయండి';

  @override
  String get downloadingAll => 'మార్గదర్శకాలు డౌన్‌లోడ్ అవుతున్నాయి...';

  @override
  String get allSaved =>
      'అన్ని మార్గదర్శకాలు సేవ్ అయ్యాయి. ఇంటర్నెట్ లేకుండా చదవవచ్చు.';

  @override
  String get developedBy => 'రూపొందించినవారు';

  @override
  String get developerCredit =>
      'డా. పి.బి. ప్రదీప్ కుమార్\nసీనియర్ శాస్త్రవేత్త & సమన్వయకర్త,\nడాట్ సెంటర్, పాడేరు, అల్లూరి సీతారామరాజు జిల్లా\nఆచార్య ఎన్.జి. రంగా వ్యవసాయ విశ్వవిద్యాలయం, గుంటూరు, ఆం.ప్ర.';

  @override
  String get helpline => 'యూనివర్సిటీ టోల్ ఫ్రీ హెల్ప్‌లైన్';

  @override
  String get universityWebsite => 'యూనివర్సిటీ వెబ్‌సైట్';

  @override
  String get privacyPolicy => 'గోప్యతా విధానం';

  @override
  String get contactSupport => 'సహాయం';

  @override
  String version(String version) {
    return 'వెర్షన్ $version';
  }
}
