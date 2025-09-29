extension StringExtensions on String {

    String get shortLocationText {
    // If it's an address, try to show just the city/area
    // ignore: unnecessary_this
    if (contains(',')) {
      final parts = split(',');
      if (parts.length >= 2) {
        // Show first two parts (usually street + area/city)
        return '${parts[0].trim()}, ${parts[1].trim()}';
      }
    }
    return this;
  }
}
