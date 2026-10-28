import 'package:angrauasr/l10n/app_localizations.dart';
import 'package:angrauasr/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../data/crop_catalog.dart';
import '../models/product_model.dart';
import '../screens/about_screen.dart';
import '../screens/pdf_screen.dart';
import '../services/contact_service.dart';
import '../services/pdf_cache_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Save every guide on the phone in the background so they can be read
    // offline later. Guides already saved are skipped.
    PdfCacheService.downloadAll(CropCatalog.allPdfFiles());
  }

  void _openGuide(String pdf, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PdfScreen(pdfPath: pdf, title: title),
      ),
    );
  }

  void _openProduct(Product product, String lang) {
    if (product.hasSubOptions) {
      showDialog(
        context: context,
        builder: (_) => SubOptionPopup(
          product: product,
          languageCode: lang,
          onSelected: (option) => _openGuide(option.pdf, option.name(lang)),
        ),
      );
    } else {
      _openGuide(product.pdf, product.name(lang));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;
    final products = CropCatalog.forLanguage(lang);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.appTitle,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              Text(
                                l10n.tagline,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: l10n.about,
                          icon: const Icon(Icons.info_outline),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AboutScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _LanguageToggle(languageCode: lang),
                    const SizedBox(height: 15),
                    _GuideSearchField(
                      languageCode: lang,
                      onSelected: (g) => _openGuide(g.pdf, g.title),
                    ),
                    const SizedBox(height: 15),
                    const _HelplineCard(),
                    const SizedBox(height: 15),
                    Text(
                      l10n.cropGuides,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _ProductTile(
                    product: products[index],
                    languageCode: lang,
                    onTap: () => _openProduct(products[index], lang),
                  ),
                  childCount: products.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  final String languageCode;

  const _LanguageToggle({required this.languageCode});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<String>(
        showSelectedIcon: false,
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: Colors.black,
          selectedForegroundColor: Colors.white,
        ),
        segments: const [
          ButtonSegment(value: 'en', label: Text('English')),
          ButtonSegment(value: 'te', label: Text('తెలుగు')),
        ],
        selected: {languageCode},
        onSelectionChanged: (s) => MyApp.setLocale(context, Locale(s.first)),
      ),
    );
  }
}

class _GuideSearchField extends StatelessWidget {
  final String languageCode;
  final ValueChanged<Guide> onSelected;

  const _GuideSearchField({required this.languageCode, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TypeAheadField<Guide>(
      // Rebuild the suggestions when the language changes.
      key: ValueKey(languageCode),
      hideOnEmpty: false,
      suggestionsCallback: (pattern) {
        final query = pattern.trim().toLowerCase();
        if (query.isEmpty) return const <Guide>[];
        return CropCatalog.guides(languageCode)
            .where(
              (g) =>
                  g.title.toLowerCase().contains(query) ||
                  g.subtitle.toLowerCase().contains(query),
            )
            .toList();
      },
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: l10n.searchHint,
            prefixIcon: const Icon(Icons.search),
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      },
      decorationBuilder: (context, child) {
        return Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 250),
            child: child,
          ),
        );
      },
      emptyBuilder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(l10n.noResults),
      ),
      itemBuilder: (context, guide) {
        return ListTile(
          leading: const Icon(Icons.menu_book_outlined),
          title: Text(guide.title),
          subtitle: guide.subtitle.isEmpty ? null : Text(guide.subtitle),
        );
      },
      onSelected: (guide) {
        FocusScope.of(context).unfocus();
        onSelected(guide);
      },
    );
  }
}

class _HelplineCard extends StatelessWidget {
  const _HelplineCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () => ContactService.callHelpline(context),
        child: Container(
          height: 109,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.universityTollfree,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0A9A4A),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Icon(Icons.phone, color: Colors.black, size: 16),
                        SizedBox(width: 6),
                        Text(
                          ContactService.helplineDisplay,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
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
    );
  }
}

class _ProductTile extends StatelessWidget {
  final Product product;
  final String languageCode;
  final VoidCallback onTap;

  const _ProductTile({
    required this.product,
    required this.languageCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: product.name(languageCode),
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Image.asset(
                  product.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
              ),
              child: Text(
                product.name(languageCode),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
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
  final String languageCode;
  final ValueChanged<SubOption> onSelected;

  const SubOptionPopup({
    super.key,
    required this.product,
    required this.languageCode,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final options = product.subOptions!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                product.name(languageCode),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(l10n.selectCrop, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 6),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: options.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, indent: 16, endIndent: 16),
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return ListTile(
                      title: Text(option.name(languageCode)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.pop(context);
                        onSelected(option);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 6),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
