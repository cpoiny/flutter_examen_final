
class Department
{

  //Constructeur
  Department(
    this.nom,
    this.code,
    this.codeRegion,
    
);

// Propriétés de la classe qui seront initialisés par le déclenchement de la méthode factory
  final String nom;
  final String code;
  final String codeRegion;
 




  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      json['nom'],
      json['code'],
      json['codeRegion'],
      
    );
  }

  
  //Getter
  String get getNom => nom;
  String get getCode => code;
  String get getcodeRegion => codeRegion;

}


// La classe la moins imbriquée

class DepartmentList{

  // constructeur
  DepartmentList({required this.departements});

  final List<Department> departements;

  factory DepartmentList.fromJson(List<dynamic> parseJson) {
    List <Department> departements = <Department>[];
    // 2. Appel Product en fromJson
    departements = parseJson.map((s) => Department.fromJson(s)).toList();
    return DepartmentList(departements : departements);
  }
}

