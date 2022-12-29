// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_catatan/db_test.dart';
import 'package:flutter_catatan/models/catatan.dart';
import 'package:flutter_catatan/pages/add_catatan.dart';
import 'package:flutter_catatan/pages/edit_catatan.dart';
import 'package:flutter_catatan/theme.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class ListCatatanPage extends StatefulWidget {
  const ListCatatanPage({super.key});

  @override
  State<ListCatatanPage> createState() => _ListCatatanState();
}

class _ListCatatanState extends State<ListCatatanPage> {
  List<CatatanModel> catatans = [];
  bool isLoading = false;
  DateTime now = DateTime.now();
  int nowAngkat = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListCatatan();
  }

  getListCatatan() async {
    setState(() {
      isLoading = true;
    });

    var data = await SQLHelper.getCatatan();
    print("data ${data.length}");
    catatans = data;
    print("data ${data.length}");
    nowAngkat = now.millisecondsSinceEpoch;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Catatan"),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: catatans.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("now ${now}");
                    print("nowAngkat ${nowAngkat}");
                    print(
                        "======================================================");
                    print(
                        "kondisi ${nowAngkat >= (catatans[index].waktu_pengingat - catatans[index].interval_pengingat)}");
                    if (nowAngkat >=
                        (catatans[index].waktu_pengingat -
                            catatans[index].interval_pengingat)) {
                      print("masuk tampil");
                      print("tampilkan alerrt ${catatans[index].judul}");

                      alert(catatans[index].judul);
                    }
                    return Card(
                      child: InkWell(
                        onTap: () {
                          print("detail id ${catatans[index].id}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditCatatan(
                                catatanModel: catatans[index],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            catatans[index].judul,
                            style: blueTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            catatans[index].deskripsi,
                            style: blackTextStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Text(
                              "${index + 1}",
                              style: whiteTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            backgroundColor: primaryColor,
                          ),
                          trailing: InkWell(
                            onTap: () async {
                              print("hapus id ${catatans[index].id}");
                              var result = await showOkCancelAlertDialog(
                                // style: AdaptiveStyle.iOS,
                                context: context,
                                isDestructiveAction: true,
                                title: Platform.isIOS ? "menghapus" : null,
                                message: "Apakah anda yakin ingin menghapus ?",
                              );

                              if (result == OkCancelResult.cancel) {
                                print("cancel");

                                return;
                              }

                              print("ya");
                              setState(() {
                                isLoading = true;
                              });
                              await SQLHelper.deleteCatatan(catatans[index].id);
                              await getListCatatan();
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        tooltip: 'Tambah',
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Tambah'),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.add,
            ),
          ],
        ),
        onPressed: () async {
          print("tambah");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCatatan(
                latest: catatans.length,
              ),
            ),
          );
        },
      ),
    );
  }

  Future alert(String judul) async {
    await Future.delayed(const Duration(seconds: 1));
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Sudah masuk waktu $judul harap segera siap-siap"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
