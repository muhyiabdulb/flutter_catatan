// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_catatan/db_test.dart';
import 'package:flutter_catatan/models/catatan.dart';
import 'package:flutter_catatan/pages/list_catatan.dart';
import 'package:flutter_catatan/theme.dart';
import 'package:flutter_catatan/widgets/ButtonWidget.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class AddCatatan extends StatefulWidget {
  int latest;
  AddCatatan({super.key, required this.latest});

  @override
  State<AddCatatan> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<AddCatatan> with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  var items = [
    'Tidak ada',
    '1 hari sebelumnya',
    '3 jam sebelumnya',
    '1 jam sebelumnya'
  ];

  File? imageFile;
  final LocalStorage storage = LocalStorage('users');
  String filePath = "";
  TextEditingController judul = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController waktu_pengingat = TextEditingController();
  int waktu_pengingat_angka = 0;
  int interval_pengingat = 0;
  TextEditingController lampiran = TextEditingController();
  bool _checkbox = true;
  String status = "Wajid diisi";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Tambah Catatan'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(
              horizontal: paddingLa,
              vertical: paddingLa,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: spaceHeight,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: inputFieldColor,
                    ),
                    child: Center(
                      child: TextFormField(
                        validator: (value) {
                          if (isValid(value.toString())) {
                            return 'Judul tidak boleh kosong';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        controller: judul,
                        cursorColor: primaryColor,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Judul',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: spaceHeight,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: inputFieldColor,
                    ),
                    child: Center(
                      child: TextFormField(
                        validator: (value) {
                          if (isValid(value.toString())) {
                            return 'Deskripsi tidak boleh kosong';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        controller: deskripsi,
                        cursorColor: primaryColor,
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Deskripsi',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: spaceHeight,
                  ),
                  _checkbox
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 45,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: inputFieldColor,
                                ),
                                child: Center(
                                  child: TextFormField(
                                    readOnly: true,
                                    validator: (value) {
                                      if (_checkbox) {
                                        if (isValid(value.toString())) {
                                          return 'Waktu pengingat tidak boleh kosong';
                                        }
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: waktu_pengingat,
                                    cursorColor: primaryColor,
                                    decoration: const InputDecoration.collapsed(
                                      hintText: 'Waktu Pengingat',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: spaceWidth,
                            ),
                            buttonTanggal(context, true),
                          ],
                        )
                      : Container(),
                  CheckboxListTile(
                    title: Text(
                      _checkbox
                          ? 'Pakai Waktu pengingat'
                          : 'Sembunyikan Waktu pengingat',
                      style: TextStyle(color: Colors.grey),
                    ),
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                        status =
                            _checkbox ? "Wajid diisi" : "Tidak wajib diisi";
                      });
                      print("_checkbox $_checkbox");
                      print("status $status");
                    },
                  ),
                  const SizedBox(
                    height: spaceHeight,
                  ),
                  _checkbox
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: inputFieldColor,
                          ),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),

                            hint: const Text(
                              "Pilih Interval Pengingat",
                            ),
                            // Initial Value
                            // value: interval_pengingat,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                            validator: (value) {
                              if (_checkbox) {
                                if (value == null) {
                                  return 'Interval Pengingat tidak boleh kosong';
                                }
                              }
                              return null;
                            },
                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),

                            onChanged: (String? newValue) {
                              print("pilih $newValue");
                              //                     'Tidak ada',
                              // '1 hari sebelumnya',
                              // '3 jam sebelumnya',
                              // '1 jam sebelumnya'
                              if (newValue == "Tidak ada") {
                                setState(() {
                                  interval_pengingat = 0;
                                });
                              } else if (newValue == "1 hari sebelumnya") {
                                setState(() {
                                  interval_pengingat = 86400000;
                                });
                              } else if (newValue == "3 jam sebelumnya") {
                                setState(() {
                                  interval_pengingat = 10800000;
                                });
                              } else if (newValue == "1 jam sebelumnya") {
                                setState(() {
                                  interval_pengingat = 3600000;
                                });
                              }
                              print("interval $interval_pengingat");
                            },
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: spaceHeight,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        minRadius: 60.0,
                        child: lampiran.text != ""
                            ? CircleAvatar(
                                radius: 50.0,
                                backgroundImage: FileImage(
                                  File(lampiran.text),
                                ),
                              )
                            : const CircleAvatar(
                                radius: 50.0,
                                backgroundImage: AssetImage(
                                  "assets/images/user.png",
                                ),
                              ),
                      ),
                      const SizedBox(
                        width: spaceWidth,
                      ),
                      buttonFile(context),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: ButtonWidget(
                            textButton: "SAVE",
                            onTap: () async {
                              print("SAVE");
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              var catatan = CatatanModel(
                                id: widget.latest + 1,
                                judul: judul.text,
                                deskripsi: deskripsi.text,
                                waktu_pengingat: waktu_pengingat_angka,
                                interval_pengingat: interval_pengingat,
                                lampiran: lampiran.text,
                              );
                              print("catatan $catatan");
                              var hasil =
                                  await SQLHelper.createCatatan(catatan);
                              print("hasil ${hasil}");

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListCatatanPage(),
                                ),
                                (route) => false,
                              );
                            },
                            backgroundColor: primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: spaceWidth,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: ButtonWidget(
                            textButton: "CANCEL",
                            onTap: () async {
                              print("CANCEL");
                              Navigator.pop(context);
                            },
                            backgroundColor: redColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonTanggal(
    BuildContext context,
    bool dari,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor,
      ),
      height: 45,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: InkWell(
        onTap: () async {
          var date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: primaryColor, // header background color
                    onPrimary: whiteColor, // header text color
                    onSurface: blackColor, // body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor, // button text color
                    ),
                  ),
                ),
                child: child ?? const SizedBox(),
              );
            },
          );

          if (date != null) {
            setState(() {
              waktu_pengingat_angka = date.millisecondsSinceEpoch;
              waktu_pengingat.text = DateFormat('yyyy-MM-dd').format(date);
            });
            print("waktu_pengingat_angka ${waktu_pengingat_angka}");
            print("waktu_pengingat ${waktu_pengingat.text}");
          }
        },
        child: Center(
          child: Text(
            'PILIH',
            style: whiteTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        ),
      ),
    );
  }

  pilihFile(String path) {
    filePath = path;

    print("filepath $filePath");
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        lampiran.text = pickedFile.path.toString();
      });

      print("image ${lampiran.text}");
    }
  }

  Widget buttonFile(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
        ),
        height: 45,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: InkWell(
          onTap: () async {
            await _getFromGallery();
          },
          child: Center(
            child: Text(
              'PILIH',
              style: whiteTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String interval_pengingat) =>
      interval_pengingat.length == 8;
  bool isNameValid(String name) => name.isEmpty || name == null;
  bool isValid(String value) {
    Pattern pattern = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern.toString());
    return value.isEmpty || regex.hasMatch(value);
  }
}
