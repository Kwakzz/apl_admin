bool hasOnlyAlphabets (String value) {
  return RegExp(r"^[a-zA-Z]+$").hasMatch(value);
}
