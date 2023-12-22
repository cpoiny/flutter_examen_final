import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/communesLister.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/sliding_menu.dart';


class CommunesPage extends StatelessWidget {
 const CommunesPage({super.key, 
 required this.title,
 required this.config,
 required this.codeRegion
 //required this.departement
 });

final Config config;
final String title;
final String codeRegion;
//final String departement;

  @override
  Widget build(BuildContext context) {
    // final String codeRegion;
    // codeRegion = config.get('regions.$region.code');



    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title:  Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: SlideMenu(config: config, currentPage: config.get('page-name.regions')),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            
            Expanded(
              child: Padding(
                padding:const EdgeInsets.all(5),
                child: Center(
                  child: CommunesLister(config: config, codeRegion: codeRegion),
                ),
              ),
              
            ),
          
          ],
        )
    );
  }
}