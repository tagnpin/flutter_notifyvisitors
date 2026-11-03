import 'dart:convert';

import 'package:nv_flutter_sdk_app/shared/widgets/models/feature_action_field.dart';

class JsonUtils {
  /// ------------------------------
  /// Normalize smart quotes (iOS fix)
  /// ------------------------------
  static String _normalize(String input) {
    return input
        .replaceAll('“', '"')
        .replaceAll('”', '"')
        .replaceAll('‘', "'")
        .replaceAll('’', "'");
  }

  /// ------------------------------
  /// Safe validation (NO throw)
  /// ------------------------------
  static bool isValidJson(String raw) {
    if (raw.trim().isEmpty) return true;

    try {
      final normalized = _normalize(raw);
      jsonDecode(normalized);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// ------------------------------
  /// Pretty print (Map / List / raw)
  /// ------------------------------
  static Map<String, dynamic>? tryPrettyJson(dynamic value) {
    try {
      if (value == null) return null;

      if (value is Map<String, dynamic>) {
        return value;
      }

      if (value is List) {
        return {'data': value};
      }

      if (value is String) {
        final normalized = _normalize(value);
        final decoded = jsonDecode(normalized);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is List) return {'data': decoded};
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  /// ------------------------------
  /// Field parsing (STRICT)
  /// Used during execution
  /// ------------------------------
  static dynamic parseFieldValue(FieldType type, String raw) {
    final value = _normalize(raw.trim());

    switch (type) {
      case FieldType.text:
        return value;

      case FieldType.number:
        if (value.isEmpty) return null;
        final numValue = num.tryParse(value);
        if (numValue == null) {
          throw const FormatException('Invalid number');
        }
        return numValue;

      case FieldType.boolean:
        if (value.toLowerCase() == 'true') return true;
        if (value.toLowerCase() == 'false') return false;
        throw const FormatException('Invalid boolean');

      case FieldType.json:
        if (value.isEmpty) return null;
        final decoded = jsonDecode(value);
        if (decoded is! Map<String, dynamic>) {
          throw const FormatException('JSON must be an object');
        }
        return decoded;

      case FieldType.array:
        if (value.isEmpty) return null;
        final decoded = jsonDecode(value);
        if (decoded is! List) {
          throw const FormatException('Array must be a JSON list');
        }
        return decoded;
    }
  }

  /// ------------------------------
  /// Pretty print raw JSON string
  /// ------------------------------
  static String prettyPrintJson(String raw) {
    final normalized = _normalize(raw);
    final decoded = jsonDecode(normalized);
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(decoded);
  }
}
