class Validator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateTime(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    // Regular expression to match "00:00" format
    final RegExp timePattern = RegExp(r'^\d{2}:\d{2}$');

    // Check if value matches the pattern
    if (!timePattern.hasMatch(value)) {
      return '$fieldName must be in the format HH:mm';
    }

    // Further validation to ensure hours and minutes are within valid ranges
    final List<String> parts = value.split(':');
    final int hours = int.parse(parts[0]);
    final int minutes = int.parse(parts[1]);

    if (hours < 0 || hours > 23) {
      return '$fieldName must have hours between 00 and 23';
    }

    if (minutes < 0 || minutes > 59) {
      return '$fieldName must have minutes between 00 and 59';
    }

    return null;
  }
}
