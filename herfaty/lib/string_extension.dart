extension StringExtensions on String {
  bool isValidEmail() {
    return RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
        .hasMatch(this);
  }

  bool isWhitespace() => this.trim().isEmpty;
  bool isvalidInt() => int.tryParse(this) != null;
}
