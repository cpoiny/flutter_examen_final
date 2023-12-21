import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/models/communes_model.dart';
import 'package:flutter_examen1/models/departement_model.dart';
import 'package:flutter_examen1/pages/communes_page.dart';
import 'package:flutter_examen1/service/commune_service.dart';
import 'package:flutter_examen1/service/department_service.dart';




// 5 - Créer le composant stateful permettant l'utilisation des models 

class CommunesLister extends StatefulWidget {
  const CommunesLister({super.key,
  required this.codeRegion,
  required this.config});


  final String codeRegion;
  final Config config;

  @override
  State<CommunesLister> createState() => _CommunesListerState();
}

class _CommunesListerState extends State<CommunesLister> {

//Données dont on a besoin
late Future<CommunesList?> communes;

// Methode init()
@override
void initState(){
  super.initState();
  loadCommunes(widget.codeRegion);
}

void loadCommunes(codeRegion){
  setState((){
    // on peut appeler notre ProductService et notre methode car ils sont en static dans la classe donc accessible ici
  communes = CommuneService.getCommunes(codeRegion);
  });
}




  @override
  Widget build(BuildContext context) {

    // Widget FutureBuilder => pour afficher des données
    return FutureBuilder(
      future: communes, 
      builder: (context, snapshot){
        // les données sont arrivées sans erreur
        if(snapshot.hasData){
          List<Communes> communes = snapshot.data!.communes;
          return ListView.builder(
            itemCount: snapshot.data!.communes.length,
            itemBuilder: (context, index){
              Communes commune = communes[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                
                  child: Card(
                    // You can customize Card properties here
                    child: ListTile(
                      title: Text(commune.nom),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Population : ${commune.population}"),
                          Text("Code Postal ${commune.code}"),
                        ],
                      ),
                      // You can handle onTap here
                      //attention si on utilise Chrome on doit mettre onTapDown() dans un gestureDetector pour encadrer ma card car Chrome ne gere pas onTap
                      onTap: () {
                        // Add your onTap logic
                      },
                    ),
                  ),
              );
            
                
              
            }
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