/// One crop card on the home screen. A crop either opens one guide (`pdf`)
/// or, like Oilseeds, Millets and Pulses, asks which crop to open
/// (`subOptions`).
class Product {
  final String nameEn;
  final String nameTe;
  final String image;
  final String pdf;
  final List<SubOption>? subOptions;

  const Product({
    required this.nameEn,
    required this.nameTe,
    required this.image,
    this.pdf = '',
    this.subOptions,
  });

  bool get hasSubOptions => subOptions != null && subOptions!.isNotEmpty;

  String name(String languageCode) => languageCode == 'te' ? nameTe : nameEn;
}

class SubOption {
  final String nameEn;
  final String nameTe;
  final String pdf;

  const SubOption({
    required this.nameEn,
    required this.nameTe,
    required this.pdf,
  });

  String name(String languageCode) => languageCode == 'te' ? nameTe : nameEn;
}

/// A single guide that can be opened, used by search.
class Guide {
  final String title;
  final String subtitle;
  final String pdf;

  const Guide({required this.title, required this.subtitle, required this.pdf});
}
