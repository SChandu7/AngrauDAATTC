import 'dart:async';
import 'dart:convert';
import 'dart:ui' show PlatformDispatcher;

import 'package:angrauasr/l10n/app_localizations.dart';
import 'package:angrauasr/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String _localeKey = 'app_locale';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // The language chosen last time; on first launch, Telugu if the phone is
  // set to Telugu, otherwise English.
  String code = PlatformDispatcher.instance.locale.languageCode == 'te'
      ? 'te'
      : 'en';
  try {
    final prefs = await SharedPreferences.getInstance();
    code = prefs.getString(_localeKey) ?? code;
  } catch (_) {}

  runApp(MyApp(initialLocale: Locale(code)));
}

class MyApp extends StatefulWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  static void setLocale(BuildContext context, Locale newLocale) {
    final state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale = widget.initialLocale;

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString(_localeKey, locale.languageCode))
        .catchError((_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ANGRAU DAATTC',
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('te')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade800,
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _splashDuration = Duration(milliseconds: 2500);

  double _timerProgress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    trackAppVisit();
    _startTimerProgress();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimerProgress() {
    const tickInterval = 50;
    int elapsed = 0;

    _timer = Timer.periodic(const Duration(milliseconds: tickInterval), (
      timer,
    ) {
      elapsed += tickInterval;
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _timerProgress = (elapsed / _splashDuration.inMilliseconds).clamp(
          0.0,
          1.0,
        );
      });
      if (elapsed >= _splashDuration.inMilliseconds) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  final String _appName = "Angrau Daattc";

  /// Counts app opens per app name on the server. Nothing about the user or
  /// the device is sent.
  Future<void> trackAppVisit() async {
    try {
      await http
          .post(
            Uri.parse("https://api.chandus7.in/api/track-visit/"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"app_name": _appName}),
          )
          .timeout(const Duration(seconds: 10));
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final green = Colors.green.shade800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        "ACHARYA N.G. RANGA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                      Text(
                        "AGRICULTURAL UNIVERSITY",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "LAM, GUNTUR, ANDHRA PRADESH",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: green,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Image.asset(
                        "assets/images/angrauicon.jpg",
                        width: MediaQuery.of(context).size.width * 0.45,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "ANGRAU DAATTC",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        l10n.developedBy,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: green,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: green, width: 2),
                        ),
                        child: Text(
                          l10n.developerCredit,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),

            /// Bottom loading bar
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _timerProgress,
                      minHeight: 4,
                      color: green,
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.loading,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
