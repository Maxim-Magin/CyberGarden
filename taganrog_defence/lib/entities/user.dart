import 'package:taganrog_defence/entities/metric.dart';
import 'package:taganrog_defence/entities/passport.dart';

class User {
  String _name;
  String _phone;
  Passport _passport;
  Metric _metric;

  User({String name, String phone, Passport passport, Metric metric})
      : _name = name,
        _phone = phone,
        _passport = passport,
        _metric = metric;

  String getUserName() => _name;
  String getUserPhone() => _phone;
}
