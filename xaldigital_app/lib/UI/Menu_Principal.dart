import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xaldigital_app/Model/Nationality.dart';
import 'package:xaldigital_app/Model/Search_history.dart';
import 'package:xaldigital_app/Services/CallApi.dart';
import 'package:xaldigital_app/Services/Database.dart';

import 'Widgets/Card.dart';
import 'Widgets/Searchbar.dart';

class menuPrincipal extends StatefulWidget {
  menuPrincipal({Key? key}) : super(key: key);

  @override
  State<menuPrincipal> createState() => _menuPrincipalState();
}

class _menuPrincipalState extends State<menuPrincipal> {


  Timer? timer;

@override
void initState() {
  super.initState();
  timer = Timer.periodic( const Duration(seconds: 5), (Timer t) => setState(() {
   
  }));
}

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("NationApps",style: TextStyle(fontWeight: FontWeight.w800),),
          backgroundColor: Colors.grey,
          actions: [ 
            IconButton(
                onPressed: ()  {
               showSearch(context: context, delegate: SearchButton());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: Center(
          child: FutureBuilder<List<HistoySearch>>(
              future: DatabaseHelper.instance.getHistorial(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<HistoySearch>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: Text('Historial sin busquedas...'));
                }
                return ListView(
                  children: snapshot.data!.map((historial) {
                    return Center(

                      //Inkwell nos sirve para poder capturar el gesto ontap ques es el que genera la accion
                      child: InkWell(
                          onTap: () {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible:
                                  false, // should dialog be dismissed when tapped outside
                              barrierLabel: "Modal", // label for barrier
                              transitionDuration: const Duration(
                                  milliseconds:
                                      500), // how long it takes to popup dialog after button click
                              pageBuilder: (_, __, ___) {
                                // your widget implementation
                                return FutureBuilder<Natyonality>(
                                  future: queryname(historial.name),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Scaffold(
                                        appBar: AppBar(
                                            backgroundColor: Colors.white,
                                            centerTitle: true,
                                            leading: IconButton(
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                            title: Text(
                                              historial.name,
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'Overpass',
                                                  fontSize: 20),
                                            ),
                                            elevation: 0.0),
                                        backgroundColor:
                                            Colors.white.withOpacity(0.90),
                                        body: Container(
                                         
                                         

                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top:  BorderSide(
                                                color: Color(0xfff8f8f8),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: SizedBox(
                    height: MediaQuery.of(context).size.height ,
                    child: ListView.builder(
                      itemCount: snapshot.data!.country.length,
                      itemBuilder: (context, index) {
                        //Manda llamar el wiget Cardinfo y le da como parametros dos strings
                        return CardInfo(
                          country: snapshot.data!.country[index]["country_id"],
                          probabilty: snapshot
                              .data!.country[index]["probability"]
                              .toString(),
                        );
                      },
                    ))
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }

                                    return const Center(
                                        child:
                                
                                             CircularProgressIndicator());
                                  },
                                );
                              },
                            );
                          },
                          child: ListTile(
                            title: Text(historial.name),
                            trailing: Wrap(
                              spacing: -15,
                              children: <Widget>[
                       
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        DatabaseHelper.instance
                                            .remove(historial.id!);
                                      });
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
                          )),
                    );
                  }).toList(),
                );
              }),
        ),
      );
}
