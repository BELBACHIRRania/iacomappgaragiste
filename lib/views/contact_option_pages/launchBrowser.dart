import 'package:url_launcher/url_launcher.dart';

Future<void> makeCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Nous ne pouvons pas passer l'appel au $url";
  }
}

Future<void> makeMail(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Nous ne pouvons pas écrire de mail à l'dresse $url";
  }
}
