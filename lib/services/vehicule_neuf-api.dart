import 'package:http/http.dart' as http;
import 'package:iacomappgaragiste/models/vehicule_neuf.dart';

Future<List<VehiculeN>> fetchVehiculeN() async {
  String url = "http://iacomapp.cest-la-base.fr/entrees.php";
  final response = await http.get(url);
  return vehiculeNFromJson(response.body);
}
