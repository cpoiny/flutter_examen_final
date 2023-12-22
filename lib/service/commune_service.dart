import 'dart:convert';

import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/models/communes_model.dart';
import 'package:flutter_examen1/models/communes_model.dart';
import 'package:http/http.dart' as http;



class CommuneService {

  CommuneService({required this.config, required this.code});

  final Config config;
  String code;

  
// url pour chrome
  //static String departmentsUrl = "https://geo.api.gouv.fr/regions/$code/departements";

// url pour emulateur
  //static String departmentsUrl = "https://geo.api.gouv.fr/regions/28/departements";



 static Future<CommunesList?> getCommunes(String code) async {

 String communesUrl = "https://geo.api.gouv.fr/departements/$code/communes";
 
    try {
      final response = await http
          .get(Uri.parse(communesUrl), headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        print(communesUrl);
        //succès de l'appli call
        if (response.body.isNotEmpty) {
          final jsonResponse = json.decode(response.body);

          final CommunesList communes = CommunesList.fromJson(jsonResponse);
          if (communes.communes.isNotEmpty) {
            return communes;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        throw Exception("Impossible de récuperer les communes 1");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Impossible de récuperer les communes 2");
    }
  }
}