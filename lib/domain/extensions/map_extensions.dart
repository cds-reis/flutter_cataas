extension MapExtensionsNullValue<K, V> on Map<K, V?> {
  Map<K, V> get nonNulls => Map.fromEntries(
        entries
            .where((element) => element.value != null)
            .map((e) => MapEntry(e.key, e.value as V)),
      );
}
