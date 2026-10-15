class PasswordHintString {
  const PasswordHintString({
    this.hasMinLengthEight = 'Contains at least 8 characters',
    this.hasOneLowercase = 'Contains at least 1 lowercase character',
    this.hasOneUppercase = 'Contains at least 1 uppercase character',
    this.hasOneNumber = 'Contains at least 1 number',
    this.hasOneSymbol = 'Contains at least 1 special character',
    this.errorPasswordRequirementsNotMeet = 'The password does not meet the requirements.',
  });

  final String hasMinLengthEight;
  final String hasOneLowercase;
  final String hasOneUppercase;
  final String hasOneNumber;
  final String hasOneSymbol;

  final String errorPasswordRequirementsNotMeet;
}
