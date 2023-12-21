import 'dart:convert';

import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/models/departement_model.dart';
import 'package:http/http.dart' as http;



class DepartmentService {

  DepartmentService({required this.config, required this.code});

  final Config config;
  String code;

  
// url pour chrome
  //static String departmentsUrl = "https://geo.api.gouv.fr/regions/$code/departements";

// url pour emulateur
  //static String departmentsUrl = "https://geo.api.gouv.fr/regions/28/departements";



 static Future<DepartmentList?> getDepartments(String code) async {

 String departmentsUrl = "https://geo.api.gouv.fr/regions/$code/departements";
    try {
      final response = await http
          .get(Uri.parse(departmentsUrl), headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        //succès de l'appli call
        if (response.body.isNotEmpty) {
          final jsonResponse = json.decode(response.body);

          final DepartmentList departements = DepartmentList.fromJson(jsonResponse);
          if (departements.departements.isNotEmpty) {
            return departements;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        throw Exception("Impossible de récuperer les departements 1");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Impossible de récuperer les departements 2");
    }
  }
}