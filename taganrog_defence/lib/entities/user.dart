import 'package:taganrog_defence/entities/metric.dart';
import 'package:taganrog_defence/entities/passport.dart';

class User {
  String _name;
  String _phone;
  Passport _passport;
  Metric _metric;
  String _status;

  User(
      {String name,
      String phone,
      Passport passport,
      Metric metric,
      String status})
      : _name = name,
        _phone = phone,
        _passport = passport,
        _metric = metric,
        _status = status;

  String getUserName() => _name;
  String getUserPhone() => _phone;
  Passport getUserPassport() => _passport;
  String getUserStatus() => _status;
  Metric getUserMetric() => _metric;

  void changeUserStatus(String status){
    _status = status;
  }
}
