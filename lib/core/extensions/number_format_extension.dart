extension IntFormatExtension on int {
  String get formattedPrice => toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]},',
  );
}

extension DoubleFormatExtension on double {
  String get formattedChangeRate {
    final sign = this >= 0 ? '+' : '';
    return '$sign${toStringAsFixed(2)}%';
  }
}
