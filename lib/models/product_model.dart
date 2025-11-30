class Product {
  final String nameKey;
  final String image;
  final String pdf;
  final List<SubOption>? subOptions; // options for oilseed/millete/pulses

  Product({
    required this.nameKey,
    required this.image,
    required this.pdf,
    this.subOptions,
  });
}

class SubOption {
  final String optionNameKey;
  final String optionPdf;

  SubOption({required this.optionNameKey, required this.optionPdf});
}
