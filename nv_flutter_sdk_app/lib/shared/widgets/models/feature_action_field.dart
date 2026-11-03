enum FieldType {
  text,
  number,
  boolean,
  json,
  array,
}

class FeatureActionField {
  final String key;
  final String label;
  final FieldType type;
  final bool required;
  final String? hint;

  const FeatureActionField({
    required this.key,
    required this.label,
    this.type = FieldType.text,
    this.required = false,
    this.hint,
  });
}
