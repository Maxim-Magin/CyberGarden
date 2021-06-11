import 'package:taganrog_defence/entities/metric.dart';
import 'package:taganrog_defence/entities/passport.dart';

class User {
  String _name;
  String _phone;
  String _email;
  Passport _passport;
  Metric _metric;
  String _status;
  bool _isAdmin;
  String _costume;

  User({
    String name,
    String phone,
    String email,
    Passport passport,
    Metric metric,
    String status,
    bool isAdmin,
    String costume,
  })  : _name = name,
        _phone = phone,
        _email = email,
        _passport = passport,
        _metric = metric,
        _status = status,
        _isAdmin = isAdmin,
        _costume = costume;

  String getUserName() => _name;
  String getUserPhone() => _phone;
  String getUserEmail() => _email;
  Passport getUserPassport() => _passport;
  String getUserStatus() => _status;
  Metric getUserMetric() => _metric;
  bool isUserAdmin() => _isAdmin;
  String getCostume() => _costume;

  void changeUserStatus(String status) {
    _status = status;
  }
}
