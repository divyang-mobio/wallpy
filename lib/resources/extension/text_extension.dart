extension TextExtension on String {
  String firstCaps() =>
      split('').first.toUpperCase() + substring(1, length).toLowerCase();
}
