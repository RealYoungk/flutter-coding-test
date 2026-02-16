enum AlertType {
  upper('상한가'),
  lower('하한가'),
  both('양방향');

  const AlertType(this.label);

  final String label;
}
