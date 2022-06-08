import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA6G6-Unte5NPYOHnCmxrJLV4Ayi1Cw0Mg",
      appId: "1:427250110997:android:a1fb46c7e5066e1730b41c",
      messagingSenderId: "427250110997",
      projectId: "mosqueteros-digitales",
    ),
  ).then((value) {
    runApp(const OrtApp());
  });
}

class OrtApp extends StatelessWidget {
  const OrtApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTR APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyOrtApp(title: 'Registar Tu Cuenta'),
    );
  }
}

class MyOrtApp extends StatefulWidget {
  const MyOrtApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyOrtApp> createState() => _MyOrtAppState();
}

class _MyOrtAppState extends State<MyOrtApp> {
  String nombreUsuario = "",
      apellidoPaternoUsuario = "",
      apellidoMaternoUsuario = "",
      correoUsuario = "",
      passwordUsuario = "",
      dniIDUsuario = "";

  getNombre(nombre) {
    nombreUsuario = nombre;
  }

  getApellidoPaterno(paterno) {
    apellidoPaternoUsuario = paterno;
  }

  getApellidoMaterno(materno) {
    apellidoMaternoUsuario = materno;
  }

  getDniID(dni) {
    dniIDUsuario = dni;
  }

  getCorreo(correo) {
    correoUsuario = correo;
  }

  getPassword(password) {
    passwordUsuario = password;
  }

  crearCuenta() {
    // ignore: avoid_print
    print("Cuenta Creada");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("usuarios").doc(dniIDUsuario);

    documentReference
        .set(
          {
            "nombreUsuario": nombreUsuario,
            "apellidoPaternoUsuario": apellidoPaternoUsuario,
            "apellidoMaternoUsuario": apellidoMaternoUsuario,
            "dniIDUsuario": dniIDUsuario,
            "correoUsuario": correoUsuario,
            "passwordUsuario": passwordUsuario,
          },
          SetOptions(merge: true),
        )
        // ignore: avoid_print
        .catchError((error) => print(
            'Ocurrió un fallo al realizar la unión de información: $error'))
        .whenComplete(() {
          // ignore: avoid_print
          print('La cuenta del usuario $nombreUsuario a sido creada');
        });
  }

  mostrarDatos() {
    // ignore: avoid_print
    print("Datos Mostrados Del Usuario: $dniIDUsuario");

    FirebaseFirestore.instance
        .collection("usuarios")
        .doc(dniIDUsuario)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // ignore: avoid_print
        print('Información de documento: ${documentSnapshot.data()}');
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        AlertDialog alerta = AlertDialog(
          title: const Text('Datos del Usuario'),
          content: Column(
            children: [
              Text('Nombre(s): ${data["nombreUsuario"]}'),
              Text(
                  'Apellidos: ${data["apellidoPaternoUsuario"]} ${data["apellidoMaternoUsuario"]}'),
              Text('ID (DNI): ${data["dniIDUsuario"]}'),
              Text('Correo: ${data["correoUsuario"]}')
            ],
          ),
        );
        showDialog(context: context, builder: (BuildContext context) => alerta);
      } else {
        AlertDialog alerta2 = const AlertDialog(
          title: Text('Datos del Usuario'),
          content: Text('NO EXISTEN DATOS'),
        );
        showDialog(
            context: context, builder: (BuildContext context) => alerta2);
        // ignore: avoid_print
        print('El documento no existe en la Base de Datos...');
      }
    });
  }

  actualizarDatos() {
    // ignore: avoid_print
    print("Datos Actualizados");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("usuarios").doc(dniIDUsuario);

    documentReference
        .update({
          "nombreUsuario": nombreUsuario,
          "apellidoPaternoUsuario": apellidoPaternoUsuario,
          "apellidoMaternoUsuario": apellidoMaternoUsuario,
          "dniIDUsuario": dniIDUsuario,
          "correoUsuario": correoUsuario,
          "passwordUsuario": passwordUsuario,
        })
        .then((value) =>
            // ignore: avoid_print
            print('Los datos del usuario $nombreUsuario han sido actualizados'))
        // ignore: avoid_print
        .catchError((error) => print('Error al actualizar los datos: $error'));
  }

  eliminarCuenta() {
    // ignore: avoid_print
    print("La cuenta del usuario $nombreUsuario a sido eliminada");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('usuarios').doc(dniIDUsuario);

    documentReference
        .delete()
        // ignore: avoid_print
        .then((value) => print('Datos del usuario $nombreUsuario eliminados'))
        // ignore: avoid_print
        .catchError((error) => print('Error al eliminar los datos: $error'));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Nombre",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String nombre) {
                  getNombre(nombre);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Apellido Paterno",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String paterno) {
                  getApellidoPaterno(paterno);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Apellido Materno",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String materno) {
                  getApellidoMaterno(materno);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Documento de Identidad",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String dni) {
                  getDniID(dni);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Correo",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String correo) {
                  getCorreo(correo);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Contraseña",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String password) {
                  getPassword(password);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  textColor: Colors.white,
                  onPressed: () {
                    crearCuenta();
                  },
                  child: const Text("Crear Cuenta"),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  textColor: Colors.white,
                  onPressed: () {
                    mostrarDatos();
                  },
                  child: const Text("Mostrar Datos"),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.indigoAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  textColor: Colors.white,
                  onPressed: () {
                    actualizarDatos();
                  },
                  child: const Text("Actualizar"),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: const Text("Eliminar Cuenta"),
                  textColor: Colors.white,
                  onPressed: () {
                    eliminarCuenta();
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: const [
                  Expanded(
                      child: Text(
                    "ID",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text(
                    "Nombre(s)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text(
                    "Apellido Paterno",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text(
                    "Apellido Materno",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text(
                    "Correo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('usuarios')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Row(
                            textDirection: TextDirection.ltr,
                            children: [
                              Expanded(
                                  child:
                                      Text(documentSnapshot["dniIDUsuario"])),
                              Expanded(
                                  child:
                                      Text(documentSnapshot["nombreUsuario"])),
                              Expanded(
                                  child: Text(documentSnapshot[
                                      "apellidoPaternoUsuario"])),
                              Expanded(
                                  child: Text(documentSnapshot[
                                      "apellidoMaternoUsuario"])),
                              Expanded(
                                  child:
                                      Text(documentSnapshot["correoUsuario"])),
                            ],
                          );
                        },
                        itemCount: snapshot.data!.docs.length);
                  } else {
                    return const Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ));
  }
}
