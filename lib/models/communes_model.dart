class Communes {
  String nom;
  String code;
  String codeDepartement;
  String siren;
  String codeEpci;
  String codeRegion;
  List<String> codesPostaux;
  int population;

Communes({
    required this.nom,
    required this.code,
    required this.codeDepartement,
    required this.siren,
    required this.codeEpci,
    required this.codeRegion,
    required this.codesPostaux,
    required this.population,
  });
   factory Communes.fromJson(Map<String, dynamic> json) => Communes(
        nom: json["nom"],
        code: json["code"],
        codeDepartement: json["codeDepartement"],
        siren: json["siren"],
        codeEpci: json["codeEpci"],
        codeRegion: json["codeRegion"],
        codesPostaux: List<String>.from(json["codesPostaux"].map((e) => e)),
        population: json["population"],
    );

  String get getNom => nom;
  String get getCode => code;
  String get getCodeDepartement => codeDepartement;
  String get getSiren => siren;
  String get getCodeEpci => codeEpci;
  String get getCodeRegion => codeRegion;
  List<String> get getCodesPostaux => codesPostaux;
  int get getPopulation => population;

}

class CommunesList {
  final List<Communes> communes;

  CommunesList ({required this.communes});

  factory CommunesList.fromJson(List<dynamic> parseJson) {
    List<Communes> communes = <Communes>[];
  communes = parseJson.map((e) => Communes.fromJson(e)).toList();
    return CommunesList (communes:communes);
  }
}