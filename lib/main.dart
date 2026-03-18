import 'package:angrauasr/l10n/app_localizations.dart';
import 'package:angrauasr/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../services/pdf_zip_service.dart';
import 'dart:io';
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
  bool _downloading = true;

  @override
  void initState() {
    super.initState();
    trackAppVisit();
    _prepareOfflineData();
  }

  final String _appName = "Angrau Daattc"; // ✅ change this per app
  // "chandus7" / "app3" / "app4" etc.

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
    // 🔹 Navigate after splash delay (NON-BLOCKING)
    Future.delayed(const Duration(seconds: 8), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });

    // 🔹 Start ZIP download in background
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
                              "Dr. P.B. Pradeep Kumar\nCoordinator & Scientist (T.O.T) DAATTC, PADERU, A.S.R. District.A.P.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Dr. A. Appalaswamy\nAssociate Director of Research, High Altitude...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Dr. G. Sivanarayana\nDirector of Extension, ANGRAU",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔽 BOTTOM DOWNLOAD PROGRESS BAR
          ],
        ),
      ),
    );
  }
}
