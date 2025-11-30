import 'package:angrauasr/l10n/app_localizations.dart';
import 'package:angrauasr/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../models/product_model.dart';
import '../screens/pdf_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Product> products = [
    Product(
      nameKey: "sugarcane",
      image: "assets/images/sugarcrane.jpg",
      pdf: "assets/pdfs/sugarcrane.pdf",
    ),
    Product(
      nameKey: "rice",
      image: "assets/images/rice.jpg",
      pdf: "assets/pdfs/rice.pdf",
    ),
    Product(
      nameKey: "oilseed",
      image: "assets/images/oilseed.jpg",
      pdf: "",
      subOptions: [
        SubOption(
          optionNameKey: "GROUNDNUT",
          optionPdf: "assets/pdfs/groundnut.pdf",
        ),
        SubOption(optionNameKey: "SESAME", optionPdf: "assets/pdfs/sesame.pdf"),
        SubOption(
          optionNameKey: "SUNFLOWER",
          optionPdf: "assets/pdfs/sunflower.pdf",
        ),
      ],
    ),
    Product(
      nameKey: "maize",
      image: "assets/images/maize.jpg",
      pdf: "assets/pdfs/maize.pdf",
    ),
    Product(
      nameKey: "mesta",
      image: "assets/images/mesta.jpg",
      pdf: "assets/pdfs/mesta.pdf",
    ),
    Product(
      nameKey: "millets",
      image: "assets/images/millete.jpg",
      pdf: "",
      subOptions: [
        SubOption(
          optionNameKey: "ANDUKORRALU",
          optionPdf: "assets/pdfs/andukorralu.pdf",
        ),
        SubOption(
          optionNameKey: "ARIKALU",
          optionPdf: "assets/pdfs/arikalu.pdf",
        ),
        SubOption(optionNameKey: "BAJRA", optionPdf: "assets/pdfs/bajra.pdf"),
        SubOption(optionNameKey: "JOWER", optionPdf: "assets/pdfs/jower.pdf"),
        SubOption(optionNameKey: "KORRA", optionPdf: "assets/pdfs/korra.pdf"),
        SubOption(optionNameKey: "OODALU", optionPdf: "assets/pdfs/oodalu.pdf"),
        SubOption(optionNameKey: "RAGI", optionPdf: "assets/pdfs/ragi.pdf"),
        SubOption(optionNameKey: "SAMA", optionPdf: "assets/pdfs/sama.pdf"),
        SubOption(optionNameKey: "VARIGA", optionPdf: "assets/pdfs/variga.pdf"),
      ],
    ),

    Product(
      nameKey: "pulses",
      image: "assets/images/pulses.jpg",
      pdf: "",
      subOptions: [
        SubOption(
          optionNameKey: "SOYABEAN",
          optionPdf: "assets/pdfs/soyabean.pdf",
        ),
        SubOption(
          optionNameKey: "REDGRAM",
          optionPdf: "assets/pdfs/redgram.pdf",
        ),
        SubOption(
          optionNameKey: "BENGALGRAM",
          optionPdf: "assets/pdfs/bengalgram.pdf",
        ),
        SubOption(
          optionNameKey: "GREEN & BLACK GRAM",
          optionPdf: "assets/pdfs/redgramblackgram.pdf",
        ),
      ],
    ),
    Product(
      nameKey: "cotton",
      image: "assets/images/cotton.jpg",
      pdf: "assets/pdfs/cotton.pdf",
    ),
    Product(
      nameKey: "BioFertilizers",
      image: "assets/images/biofertilizers.jpg",
      pdf: "assets/pdfs/liquid.pdf",
    ),
    Product(
      nameKey: "BioControl",
      image: "assets/images/biocontrol.jpg",
      pdf: "assets/pdfs/biocontrol.pdf",
    ),
    Product(
      nameKey: "IntegratedWeedManagement",
      image: "assets/images/angrauicon.jpg",
      pdf: "assets/pdfs/angruv.pdf",
    ),
  ];

  List<Product> products2 = [
    Product(
      nameKey: "sugarcane",
      image: "assets/images/sugarcrane.jpg",
      pdf: "assets/pdfs/sugarcrane2.pdf",
    ),
    Product(
      nameKey: "rice",
      image: "assets/images/rice.jpg",
      pdf: "assets/pdfs/rice2.pdf",
    ),
    Product(
      nameKey: "oilseed",
      image: "assets/images/oilseed.jpg",
      pdf: "",
      subOptions: [
        SubOption(
          optionNameKey: "GROUNDNUT",
          optionPdf: "assets/pdfs/groundnut2.pdf",
        ),
        SubOption(
          optionNameKey: "SESAME",
          optionPdf: "assets/pdfs/sesame2.pdf",
        ),
        SubOption(
          optionNameKey: "SUNFLOWER",
          optionPdf: "assets/pdfs/sunflower2.pdf",
        ),
      ],
    ),
    Product(
      nameKey: "maize",
      image: "assets/images/maize.jpg",
      pdf: "assets/pdfs/maize2.pdf",
    ),
    Product(
      nameKey: "mesta",
      image: "assets/images/mesta.jpg",
      pdf: "assets/pdfs/mesta.pdf",
    ),
    Product(
      nameKey: "millets",
      image: "assets/images/millete.jpg",
      pdf: "assets/pdfs/millets2.pdf",
    ),

    Product(
      nameKey: "pulses",
      image: "assets/images/pulses.jpg",
      pdf: "",
      subOptions: [
        SubOption(
          optionNameKey: "REDGRAM",
          optionPdf: "assets/pdfs/redgram2.pdf",
        ),
        SubOption(
          optionNameKey: "GREENGRAM",
          optionPdf: "assets/pdfs/greengram2.pdf",
        ),
        SubOption(
          optionNameKey: "BLACKGRAM",
          optionPdf: "assets/pdfs/blackgram2.pdf",
        ),
      ],
    ),
    Product(
      nameKey: "cotton",
      image: "assets/images/cotton.jpg",
      pdf: "assets/pdfs/cotton2.pdf",
    ),
    Product(
      nameKey: "BioFertilizers",
      image: "assets/images/biofertilizers.jpg",
      pdf: "assets/pdfs/liquid.pdf",
    ),
    Product(
      nameKey: "BioControl",
      image: "assets/images/biocontrol.jpg",
      pdf: "assets/pdfs/biocontrol.pdf",
    ),
    Product(
      nameKey: "IntegratedWeed Management",
      image: "assets/images/angrauicon.jpg",
      pdf: "assets/pdfs/angruv.pdf",
    ),
  ];

  List<Product> get currentProducts {
    String lang = Localizations.localeOf(context).languageCode;
    return lang == "te" ? products2 : products;
  }

  String getTranslatedValue(BuildContext context, String key) {
    switch (key) {
      case "sugarcane":
        return AppLocalizations.of(context)!.sugarcrane;
      case "rice":
        return AppLocalizations.of(context)!.rice;
      case "oilseed":
        return AppLocalizations.of(context)!.oilseed;
      case "maize":
        return AppLocalizations.of(context)!.maize;
      case "mesta":
        return AppLocalizations.of(context)!.mesta;
      case "millets":
        return AppLocalizations.of(context)!.millets;
      case "pulses":
        return AppLocalizations.of(context)!.pulses;
      case "cotton":
        return AppLocalizations.of(context)!.cotton;
      case "bioFertilizers":
        return AppLocalizations.of(context)!.bioFertilizers;
      case "bioControl":
        return AppLocalizations.of(context)!.bioControl;
      case "integratedWeedManagement":
        return AppLocalizations.of(context)!.integratedWeedManagement;
      default:
        return key;
    }
  }

  Future<String> getPdfPath(String pdf, BuildContext context) async {
    String lang = Localizations.localeOf(context).languageCode;

    if (lang == "te") {
      String tePdf = pdf.replaceAll(".pdf", "2.pdf");

      bool exists = await rootBundle
          .load(tePdf)
          .then((_) => true)
          .catchError((_) => false);

      return exists ? tePdf : pdf;
    }

    return pdf; // return english if language is EN
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.hiUser,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),

                  Container(
                    height: 38,
                    width: 140,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 1.4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              MyApp.setLocale(context, Locale('en'));
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    Localizations.localeOf(
                                          context,
                                        ).languageCode ==
                                        "en"
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "English",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Localizations.localeOf(
                                            context,
                                          ).languageCode ==
                                          "en"
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              MyApp.setLocale(context, Locale('te'));
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    Localizations.localeOf(
                                          context,
                                        ).languageCode ==
                                        "te"
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "తెలుగు",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Localizations.localeOf(
                                            context,
                                          ).languageCode ==
                                          "te"
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Text(
                AppLocalizations.of(context)!.enjoyServices,
                style: TextStyle(color: Colors.grey),
              ),

              SizedBox(height: 15),

              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.74,
                    height: 47,

                    child: TypeAheadField<Product>(
                      suggestionsCallback: (pattern) {
                        return currentProducts
                            .where(
                              (product) => getTranslatedValue(
                                context,
                                product.nameKey,
                              ).toLowerCase().contains(pattern.toLowerCase()),
                            )
                            .toList();
                      },
                      builder: (context, controller, focusNode) {
                        _searchController.value = controller.value;
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.searchHint,
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },

                      // LIMIT dropdown height so max 5 items
                      decorationBuilder: (context, child) {
                        return Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(12),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 250, // fits ~5 tiles then scrolls
                            ),
                            child: child,
                          ),
                        );
                      },

                      itemBuilder: (context, Product suggestion) {
                        return ListTile(title: Text(suggestion.nameKey));
                      },

                      onSelected: (Product suggestion) async {
                        String lang = Localizations.localeOf(
                          context,
                        ).languageCode;
                        String selectedPdf;

                        if (lang == "te") {
                          selectedPdf = suggestion.pdf; // direct Telugu file
                        } else {
                          selectedPdf = await getPdfPath(
                            suggestion.pdf,
                            context,
                          ); // English logic
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PdfScreen(
                              pdfPath: selectedPdf,
                              title: suggestion.nameKey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => FilterPopup(),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.tune, color: Colors.white),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),

              Card(
                elevation: 4,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: () {
                    final Uri callUri = Uri(scheme: 'tel', path: '18004250430');
                    launchUrl(callUri);
                  },
                  child: Container(
                    height: 109,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              final Uri callUri = Uri(
                                scheme: 'tel',
                                path: '18004250430',
                              );
                              launchUrl(callUri);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.universityTollfree,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF0A9A4A), // Green as image
                                  ),
                                ),
                                SizedBox(height: 12),
                                GestureDetector(
                                  onTap: () async {
                                    final Uri callUri = Uri(
                                      scheme: 'tel',
                                      path: '18004250430',
                                    );
                                    await launchUrl(callUri);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                        size: 16,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "18004250430",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              "assets/images/callicon.jpg",
                              height: 95,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.featuredProducts,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  physics: BouncingScrollPhysics(), // enables scrolling
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.93,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: currentProducts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (currentProducts[index].subOptions == null ||
                            currentProducts[index].subOptions!.isEmpty) {
                          String lang = Localizations.localeOf(
                            context,
                          ).languageCode;
                          String selectedPdf;

                          if (lang == "te") {
                            selectedPdf =
                                currentProducts[index].pdf; // Telugu direct
                          } else {
                            selectedPdf = await getPdfPath(
                              currentProducts[index].pdf,
                              context,
                            );
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PdfScreen(
                                pdfPath: selectedPdf,
                                title: getTranslatedValue(
                                  context,
                                  currentProducts[index].nameKey,
                                ),
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                SubOptionPopup(product: currentProducts[index]),
                          );
                        }
                      },

                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                currentProducts[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: double.infinity, // full width
                            padding: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black, // background full width
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              getTranslatedValue(
                                context,
                                currentProducts[index].nameKey,
                              ),

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterPopup extends StatefulWidget {
  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  bool seeds = false;
  bool products = false;
  bool fertilizers = false;
  bool others = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        width: 280,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),

            /// 2 x 2 GRID CHECKBOXES
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 3.8,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: seeds,
                      onChanged: (v) => setState(() => seeds = v!),
                    ),
                    Text("Seeds"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: products,
                      onChanged: (v) => setState(() => products = v!),
                    ),
                    Text("Products"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: fertilizers,
                      onChanged: (v) => setState(() => fertilizers = v!),
                    ),
                    Text("Fertilizers"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: others,
                      onChanged: (v) => setState(() => others = v!),
                    ),
                    Text("Others"),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12),

            /// SMALL OK BUTTON
            SizedBox(
              height: 34,
              width: 80,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubOptionPopup extends StatelessWidget {
  final Product product;

  const SubOptionPopup({required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            ...product.subOptions!.asMap().entries.map((entry) {
              int index = entry.key;
              var option = entry.value;

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PdfScreen(
                            pdfPath: option.optionPdf,
                            title: option.optionNameKey,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslatedValue(context, option.optionNameKey),
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),

                  // DIVIDER CENTERED
                  if (index != product.subOptions!.length - 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Container(
                          width: 250, // adjust width size here
                          height: 1.4,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      ),
                    ),
                ],
              );
            }).toList(),

            SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }

  String getTranslatedValue(BuildContext context, String key) {
    switch (key) {
      case "sugarcane":
        return AppLocalizations.of(context)!.sugarcrane;
      case "rice":
        return AppLocalizations.of(context)!.rice;
      case "oilseed":
        return AppLocalizations.of(context)!.oilseed;
      case "maize":
        return AppLocalizations.of(context)!.maize;
      case "mesta":
        return AppLocalizations.of(context)!.mesta;
      case "millets":
        return AppLocalizations.of(context)!.millets;
      case "pulses":
        return AppLocalizations.of(context)!.pulses;
      case "cotton":
        return AppLocalizations.of(context)!.cotton;
      case "bioFertilizers":
        return AppLocalizations.of(context)!.bioFertilizers;
      case "bioControl":
        return AppLocalizations.of(context)!.bioControl;
      case "integratedWeedManagement":
        return AppLocalizations.of(context)!.integratedWeedManagement;
      default:
        return key;
    }
  }
}
