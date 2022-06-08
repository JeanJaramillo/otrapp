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
      passwordUsuario = "";

  int dniIDUsuario = 0;

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
    dniIDUsuario = int.parse(dni);
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
        FirebaseFirestore.instance.collection("usuarios").doc(nombreUsuario);

    Map<String, dynamic> usuarioModelo = {
      "nombreUsuario": nombreUsuario,
      "apellidoPaternoUsuario": apellidoPaternoUsuario,
      "apellidoMaternoUsuario": apellidoMaternoUsuario,
      "dniIDUsuario": dniIDUsuario,
      "correoUsuario": correoUsuario,
      "passwordUsuario": passwordUsuario,
    };

    documentReference.set(usuarioModelo).whenComplete(() {
      // ignore: avoid_print
      print("El usuario $nombreUsuario ha sido creado");
    });
  }

  mostrarDatos() {
    // ignore: avoid_print
    print("Datos Mostrados");
  }

  actualizarDatos() {
    // ignore: avoid_print
    print("Datos Actualizados");
  }

  eliminarCuenta() {
    // ignore: avoid_print
    print("Cuenta Eliminada");
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
        body: Column(
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
            )
          ],
        ));
  }
}
