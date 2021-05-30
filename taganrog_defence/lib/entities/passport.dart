class Passport {
  int _series;
  int _number;
  PassportType _type;

  Passport({int series, int number, PassportType type})
      : _series = series,
        _number = number,
        _type = type;

  PassportType getPassportType() => _type;
}

enum PassportType { Standard, VIP }
