import 'package:angrauasr/data/crop_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final lang in ['en', 'te']) {
    test('every $lang crop opens a guide or lists sub-crops', () {
      for (final p in CropCatalog.forLanguage(lang)) {
        expect(
          p.hasSubOptions || p.pdf.endsWith('.pdf'),
          isTrue,
          reason: p.nameEn,
        );
        for (final s in p.subOptions ?? []) {
          expect(s.pdf.endsWith('.pdf'), isTrue, reason: s.nameEn);
        }
      }
    });

    test('search finds sub-crops in $lang', () {
      final guides = CropCatalog.guides(lang);
      expect(guides.every((g) => g.pdf.isNotEmpty), isTrue);
      expect(guides.any((g) => g.pdf.startsWith('groundnut')), isTrue);
    });
  }
}
