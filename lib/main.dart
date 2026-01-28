import 'package:angrauasr/l10n/app_localizations.dart';
import 'package:angrauasr/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../services/pdf_zip_service.dart';


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
    _prepareOfflineData();
  }

  Future<void> _prepareOfflineData() async {
  // 🔹 Navigate after splash delay (NON-BLOCKING)
  Future.delayed(const Duration(seconds: 2), () {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: _progress,
                    minHeight: 6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _progress == 0
                        ? "Preparing offline content..."
                        : "Downloading PDFs ${(100 * _progress).toInt()}%",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
