import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/models/departement_model.dart';
import 'package:flutter_examen1/pages/communes_page.dart';
import 'package:flutter_examen1/service/department_service.dart';




// 5 - Créer le composant stateful permettant l'utilisation des models 

class DepartmentsLister extends StatefulWidget {
  const DepartmentsLister({super.key,
  required this.codeRegion,
  required this.config,
  required this.region});


  final String codeRegion;
  final Config config;
  final String region;

  @override
  State<DepartmentsLister> createState() => _DepartmentsListerState();
}

class _DepartmentsListerState extends State<DepartmentsLister> {

//Données dont on a besoin
late Future<DepartmentList?> departements;

// Methode init()
@override
void initState(){
  super.initState();
  loadDepartments(widget.codeRegion);
}

void loadDepartments(codeRegion){
  setState((){
    // on peut appeler notre DepartmentService et notre methode car ils sont en static dans la classe donc accessible ici
  departements = DepartmentService.getDepartments(codeRegion);
  });
}




  @override
  Widget build(BuildContext context) {

    // Widget FutureBuilder => pour afficher des données
    return FutureBuilder(
      future: departements, 
      builder: (context, snapshot){
        // les données sont arrivées sans erreur
        if(snapshot.hasData){
          List<Department> departements = snapshot.data!.departements;
          return 
          Column(
            children:<Widget>[
              SizedBox(
                height: 50,
             child: Text(
              "La région ${widget.region} (${widget.codeRegion}) compte ${departements.length} départements. \n Cliquez sur l'un des départements pour en savoir plus...",
              style: const TextStyle(
                fontWeight: FontWeight.w900
              ),
             ),
             ),
              
              Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.departements.length,
                itemBuilder: (context, index){
                  Department departement = departements[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTapDown: (value){
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) =>
                          CommunesPage(config: widget.config,
                          title: "Recherche du departement: ${departement.nom}",
                          codeRegion: departement.code,
                          ),
                        ),
                    );
              
                      },
                      child: Card(
                        // You can customize Card properties here
                        child: ListTile(
                          title: Text(departement.nom),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Code du departement : ${departement.code}"),
                            ],
                          ),
                          // You can handle onTap here
                          //attention si on utilise Chrome on doit mettre onTapDown() dans un gestureDetector pour encadrer ma card car Chrome ne gere pas onTap
                          onTap: () {
                            // Add your onTap logic
                          },
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
            ],
          );



          // les données sont arrivées avec des erreurs
        } else if (snapshot.hasError){
          return Text("error: ${snapshot.error}");
        }

        // Les données ne sont pas encore arrivées et il n'y a pas d'erreurs
        return const Expanded(
          child: Center (
            // affichage du spinner
            child: CircularProgressIndicator(),
          ),
        );
      });
  }
}