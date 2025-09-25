int safeGetInt(Map<String, dynamic> json, List<String> path, {int defaultValue = 0}) {
  dynamic current = json;
  for (int i = 0; i < path.length; i++) {
    if (current is Map<String, dynamic> && current.containsKey(path[i])) {
      current = current[path[i]];
    } else {
      return defaultValue;
    }
  }

  if (current is int) {
    return current;
  }
  if (current is String) {
    return int.tryParse(current) ?? defaultValue;
  }
  return defaultValue;
}
