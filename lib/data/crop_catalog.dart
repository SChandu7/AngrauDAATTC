import '../models/product_model.dart';

/// Crop guides shown on the home screen. The English and Telugu guides are
/// different PDFs (Telugu files end in "2.pdf"), so each language has its own
/// list. File names must match the files in
/// https://api.chandus7.in/media/angraudaattcpdfs/.
class CropCatalog {
  static const List<Product> english = [
    Product(
      nameEn: 'Sugarcane',
      nameTe: 'చెరకు',
      image: 'assets/images/sugarcrane.jpg',
      pdf: 'sugarcrane.pdf',
    ),
    Product(
      nameEn: 'Rice',
      nameTe: 'వరి',
      image: 'assets/images/rice.jpg',
      pdf: 'rice.pdf',
    ),
    Product(
      nameEn: 'Oilseeds',
      nameTe: 'నూనెగింజలు',
      image: 'assets/images/oilseed.jpg',
      subOptions: [
        SubOption(nameEn: 'Groundnut', nameTe: 'వేరుశనగ', pdf: 'groundnut.pdf'),
        SubOption(nameEn: 'Sesame', nameTe: 'నువ్వులు', pdf: 'sesame.pdf'),
        SubOption(
          nameEn: 'Sunflower',
          nameTe: 'పొద్దుతిరుగుడు',
          pdf: 'sunflower.pdf',
        ),
        SubOption(nameEn: 'Castor', nameTe: 'ఆముదం', pdf: 'castor.pdf'),
        SubOption(nameEn: 'Niger', nameTe: 'వలిసెలు', pdf: 'niger.pdf'),
        // The file on the server is named "Saffover.pdf".
        SubOption(nameEn: 'Safflower', nameTe: 'కుసుమ', pdf: 'Saffover.pdf'),
      ],
    ),
    Product(
      nameEn: 'Maize',
      nameTe: 'మొక్కజొన్న',
      image: 'assets/images/maize.jpg',
      pdf: 'maize.pdf',
    ),
    Product(
      nameEn: 'Mesta',
      nameTe: 'గోగు',
      image: 'assets/images/mesta.jpg',
      pdf: 'mesta.pdf',
    ),
    Product(
      nameEn: 'Millets',
      nameTe: 'చిరుధాన్యాలు',
      image: 'assets/images/millete.jpg',
      subOptions: [
        SubOption(
          nameEn: 'Browntop Millet (Andukorralu)',
          nameTe: 'అండుకొర్రలు',
          pdf: 'andukorralu.pdf',
        ),
        SubOption(
          nameEn: 'Kodo Millet (Arikalu)',
          nameTe: 'అరికలు',
          pdf: 'arikalu.pdf',
        ),
        SubOption(nameEn: 'Bajra', nameTe: 'సజ్జలు', pdf: 'bajra.pdf'),
        SubOption(nameEn: 'Jowar', nameTe: 'జొన్నలు', pdf: 'jower.pdf'),
        SubOption(
          nameEn: 'Foxtail Millet (Korra)',
          nameTe: 'కొర్రలు',
          pdf: 'korra.pdf',
        ),
        SubOption(
          nameEn: 'Barnyard Millet (Oodalu)',
          nameTe: 'ఊదలు',
          pdf: 'oodalu.pdf',
        ),
        SubOption(nameEn: 'Ragi', nameTe: 'రాగులు', pdf: 'ragi.pdf'),
        SubOption(
          nameEn: 'Little Millet (Sama)',
          nameTe: 'సామలు',
          pdf: 'sama.pdf',
        ),
        SubOption(
          nameEn: 'Proso Millet (Variga)',
          nameTe: 'వరిగలు',
          pdf: 'variga.pdf',
        ),
      ],
    ),
    Product(
      nameEn: 'Pulses',
      nameTe: 'పప్పుధాన్యాలు',
      image: 'assets/images/pulses.jpg',
      subOptions: [
        SubOption(nameEn: 'Soybean', nameTe: 'సోయాచిక్కుడు', pdf: 'soyabean.pdf'),
        SubOption(nameEn: 'Redgram', nameTe: 'కంది', pdf: 'redgram.pdf'),
        SubOption(nameEn: 'Bengalgram', nameTe: 'శనగ', pdf: 'bengalgram.pdf'),
        SubOption(
          nameEn: 'Green & Black Gram',
          nameTe: 'పెసర & మినుము',
          pdf: 'redgramblackgram.pdf',
        ),
        SubOption(nameEn: 'Rajmash', nameTe: 'రాజ్మా', pdf: 'rajmash.pdf'),
      ],
    ),
    Product(
      nameEn: 'Cotton',
      nameTe: 'పత్తి',
      image: 'assets/images/cotton.jpg',
      pdf: 'cotton.pdf',
    ),
    Product(
      nameEn: 'Bio-fertilizers',
      nameTe: 'జీవన ఎరువులు',
      image: 'assets/images/biofertilizers.jpg',
      pdf: 'liquid.pdf',
    ),
    Product(
      nameEn: 'Bio-control',
      nameTe: 'జీవ నియంత్రణ',
      image: 'assets/images/biocontrol.jpg',
      pdf: 'biocontrol.pdf',
    ),
    Product(
      nameEn: 'Integrated Weed Management',
      nameTe: 'సమగ్ర కలుపు యాజమాన్యం',
      image: 'assets/images/angrauicon.jpg',
      pdf: 'angruv.pdf',
    ),
    Product(
      nameEn: 'Management of Saline Soils',
      nameTe: 'చౌడు నేలల యాజమాన్యం',
      image: 'assets/images/angrauicon.jpg',
      pdf: 'saline.pdf',
    ),
  ];

  static const List<Product> telugu = [
    Product(
      nameEn: 'Sugarcane',
      nameTe: 'చెరకు',
      image: 'assets/images/sugarcrane.jpg',
      pdf: 'sugarcrane2.pdf',
    ),
    Product(
      nameEn: 'Rice',
      nameTe: 'వరి',
      image: 'assets/images/rice.jpg',
      pdf: 'rice2.pdf',
    ),
    Product(
      nameEn: 'Oilseeds',
      nameTe: 'నూనెగింజలు',
      image: 'assets/images/oilseed.jpg',
      subOptions: [
        SubOption(nameEn: 'Groundnut', nameTe: 'వేరుశనగ', pdf: 'groundnut2.pdf'),
        SubOption(nameEn: 'Sesame', nameTe: 'నువ్వులు', pdf: 'sesame2.pdf'),
        SubOption(
          nameEn: 'Sunflower',
          nameTe: 'పొద్దుతిరుగుడు',
          pdf: 'sunflower2.pdf',
        ),
      ],
    ),
    Product(
      nameEn: 'Maize',
      nameTe: 'మొక్కజొన్న',
      image: 'assets/images/maize.jpg',
      pdf: 'maize2.pdf',
    ),
    Product(
      nameEn: 'Mesta',
      nameTe: 'గోగు',
      image: 'assets/images/mesta.jpg',
      pdf: 'mesta.pdf',
    ),
    Product(
      nameEn: 'Millets',
      nameTe: 'చిరుధాన్యాలు',
      image: 'assets/images/millete.jpg',
      pdf: 'millets2.pdf',
    ),
    Product(
      nameEn: 'Pulses',
      nameTe: 'పప్పుధాన్యాలు',
      image: 'assets/images/pulses.jpg',
      subOptions: [
        SubOption(nameEn: 'Redgram', nameTe: 'కంది', pdf: 'redgram2.pdf'),
        SubOption(nameEn: 'Greengram', nameTe: 'పెసర', pdf: 'greengram2.pdf'),
        SubOption(nameEn: 'Blackgram', nameTe: 'మినుము', pdf: 'blackgram2.pdf'),
      ],
    ),
    Product(
      nameEn: 'Cotton',
      nameTe: 'పత్తి',
      image: 'assets/images/cotton.jpg',
      pdf: 'cotton2.pdf',
    ),
    Product(
      nameEn: 'Bio-fertilizers',
      nameTe: 'జీవన ఎరువులు',
      image: 'assets/images/biofertilizers.jpg',
      pdf: 'liquid.pdf',
    ),
    Product(
      nameEn: 'Bio-control',
      nameTe: 'జీవ నియంత్రణ',
      image: 'assets/images/biocontrol.jpg',
      pdf: 'biocontrol.pdf',
    ),
    Product(
      nameEn: 'Integrated Weed Management',
      nameTe: 'సమగ్ర కలుపు యాజమాన్యం',
      image: 'assets/images/angrauicon.jpg',
      pdf: 'angruv.pdf',
    ),
  ];

  static List<Product> forLanguage(String languageCode) =>
      languageCode == 'te' ? telugu : english;

  /// Every guide in a language, sub-crops included, for search.
  static List<Guide> guides(String languageCode) {
    final result = <Guide>[];
    for (final p in forLanguage(languageCode)) {
      if (p.hasSubOptions) {
        for (final s in p.subOptions!) {
          result.add(
            Guide(
              title: s.name(languageCode),
              subtitle: p.name(languageCode),
              pdf: s.pdf,
            ),
          );
        }
      } else {
        result.add(Guide(title: p.name(languageCode), subtitle: '', pdf: p.pdf));
      }
    }
    return result;
  }

  /// Every PDF in both languages, without duplicates.
  static List<String> allPdfFiles() {
    final files = <String>{};
    for (final p in [...english, ...telugu]) {
      if (p.pdf.isNotEmpty) files.add(p.pdf);
      for (final s in p.subOptions ?? const <SubOption>[]) {
        files.add(s.pdf);
      }
    }
    return files.toList();
  }
}
