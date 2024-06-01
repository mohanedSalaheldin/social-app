import 'package:intl/intl.dart';

bool emailValid(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);
bool passwordValid(String password) {
  RegExp regex =
   
   
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  return regex.hasMatch(password);
}



String formateDate({required String date}) {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat.yMd().add_jm().format(dateTime);
    }