import 'package:flutter/material.dart';
import 'package:flutter_catatan/db_test.dart';
import 'package:flutter_catatan/models/catatan.dart';
import 'package:flutter_catatan/pages/list_catatan.dart';
import 'package:flutter_catatan/pages/splash.dart';

void main() async {
  runApp(const MyApp());
  // var catatan = CatatanModel(
  //   id: 1,
  //   judul: "judul",
  //   deskripsi: "deskripsi",
  //   waktu_pengingat: 10,
  //   interval_pengingat: 12,
  //   lampiran: "lampiran",
  // );
  // var hasil = await SQLHelper.createCatatan(catatan);
  // print("hasil ${hasil}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
