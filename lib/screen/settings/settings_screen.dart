import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pondok207/screen/auth/login_screen.dart';
import 'package:pondok207/screen/component/trasition_item.dart';
import 'package:pondok207/screen/settings/password_screen.dart';
import 'package:pondok207/screen/settings/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final nama = TextEditingController();
  final email = TextEditingController();
  final nope = TextEditingController();
  final alamat = TextEditingController();

  String? idUser;
  String? emailPref;

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("is_login");
      preferences.remove("email");
    });
    Navigator.pushAndRemoveUntil(
      context,
      TransisiHalaman(
          tipe: PageTransitionType.rightToLeftWithFade, page: LoginScreen()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  getDataPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idUser = pref.getString('id');
    emailPref = pref.getString('email');
  }

  FutureOr refresh() async {
    await getDataPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          margin: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //BAGIAN ATASS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Atur Akunmu',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Lengkapi datamu disini,',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    TransisiHalaman(
                      tipe: PageTransitionType.leftToRightWithFade,
                      page: ProfileScreen(id: idUser ?? ''),
                    ),
                  );
                },
              ),
              GestureDetector(
                child: const ListTile(
                  leading: Icon(Icons.key_rounded),
                  title: Text('Ubah Password'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    TransisiHalaman(
                      tipe: PageTransitionType.rightToLeftWithFade,
                      page: PasswordScreen(
                        iduser: idUser ?? '',
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              GestureDetector(
                child: const ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text('Keluar'),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: const Text('Yakin ingin keluar?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            logOut();
                            Navigator.pop(context);
                          },
                          child: const Text('Keluar'),
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
