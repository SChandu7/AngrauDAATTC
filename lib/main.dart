import 'package:angrauasr/l10n/app_localizations.dart';
import 'package:angrauasr/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../services/pdf_zip_service.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      supportedLocales: [Locale('en'), Locale('te')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  double _timerProgress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    trackAppVisit();
    _prepareOfflineData();
    _startTimerProgress();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimerProgress() {
    const totalDuration = 5000;
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
        _timerProgress = (elapsed / totalDuration).clamp(0.0, 1.0);
      });
      if (elapsed >= totalDuration) timer.cancel();
    });
  }

  final String _appName = "Angrau Daattc";

  Future<void> trackAppVisit() async {
    try {
      print("..............-----------------------------------------000");
      await http.post(
        Uri.parse("https://api.chandus7.in/api/track-visit/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"app_name": _appName}),
      );
    } catch (e) {
      print("Visit tracking failed: $e");
    }
  }

  Future<void> _prepareOfflineData() async {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });

    PdfZipService.downloadAndExtract(
      onProgress: (p) {
        if (mounted) {
          setState(() => _progress = p);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// MAIN CONTENT (UNCHANGED)
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),

                      Text(
                        "ACHARYA N.G RANGA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      Text(
                        "AGRICULTURAL UNIVERSITY",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "LAM, GUNTUR, ANDHRA PRADESH",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade800,
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
                        "ANGRAU",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "Developed by",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.93,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.green.shade800,
                            width: 2,
                          ),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              "DR. P.B. PRADEEP KUMAR\nSENIOR SCIENTIST  & COORDINATOR,\n DAATTC-PADERU,ALLURI SITARAMARAJU DISTRICT\n ACHARYA N.G.RANGA AGRICULTURAL UNIVERSITY,GUNTUR,A.P.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔽 BOTTOM LOADING PROGRESS BAR
            /// 🔽 BOTTOM LOADING PROGRESS BAR
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      // Gray background line
                      Container(
                        height: 4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      // Blue filled line (progress)
                      FractionallySizedBox(
                        widthFactor: _timerProgress,
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w400,
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
