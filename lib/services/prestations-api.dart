import 'package:http/http.dart' as http;
import 'package:iacomappgaragiste/models/article.dart';

Future<List<Article>> fetchArticle() async {
  String url = "http://iacomapp.cest-la-base.fr/prestations.php";
  final response = await http.get(url);
  return articleFromJson(response.body);
}
