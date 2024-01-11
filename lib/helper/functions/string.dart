/// Checks if a string has only alphabets and spaces
bool hasOnlyAlphabetsAndSpaces(String value) {
  return RegExp(r"^[a-zA-Z ]+$").hasMatch(value);
}

