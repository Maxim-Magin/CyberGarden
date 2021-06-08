import 'package:taganrog_defence/entities/metric.dart';
import 'package:taganrog_defence/entities/passport.dart';

class User {
  String _name;
  String _phone;
  Passport _passport;
  Metric _metric;
  String _status;
  bool _isAdmin;

  User(
      {String name,
      String phone,
      Passport passport,
      Metric metric,
      String status,
      bool isAdmin,
      })
      : _name = name,
        _phone = phone,
        _passport = passport,
        _metric = metric,
        _status = status,
        _isAdmin = isAdmin;

  String getUserName() => _name;
  String getUserPhone() => _phone;
  Passport getUserPassport() => _passport;
  String getUserStatus() => _status;
  Metric getUserMetric() => _metric;
  bool isUserAdmin() => _isAdmin;

  void changeUserStatus(String status){
    _status = status;
  }
}
