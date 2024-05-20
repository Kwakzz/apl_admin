/// Checks if a string has only alphabets, spaces and hyphens
bool hasOnlyAlphabetsAndSpacesAndHyphens(String value) {
  return RegExp(r"^[a-zA-Z\s-]+$").hasMatch(value);
}

