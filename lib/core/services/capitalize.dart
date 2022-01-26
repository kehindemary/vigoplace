String capitalize(String? string) {
  if (string == null) {
    return "";
  }
  return "${string[0].toUpperCase()}${string.substring(1)}";
}
