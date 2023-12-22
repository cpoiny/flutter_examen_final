import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/departmentsLister.dart';
import 'package:flutter_examen1/components/search_bar.dart';
import 'package:flutter_examen1/components/sliding_menu.dart';
import 'package:flutter_examen1/components/svg_map.dart';

class DepartementsPage extends StatelessWidget {
 const DepartementsPage({super.key, 
 required this.title,
 required this.config,
 required this.region
 });

final Config config;
final String title;
final String region;

  @override
  Widget build(BuildContext context) {
    final String codeRegion;
    codeRegion = config.get('regions.$region.code');



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
                padding:const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Center(
                  child: DepartmentsLister(config: config, codeRegion: codeRegion, region: region),
                ),
              ),
              
            ),
          
          ],
        )
      
      
      
    );
  }
}