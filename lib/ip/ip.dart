
// var u = 'http://172.16.7.178:8081' ;
import 'package:shared_preferences/shared_preferences.dart';

var u = 'http://192.168.1.81:8081' ;

getIdSup() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int? intValue = prefs.getInt('idSup');
  return intValue;
}