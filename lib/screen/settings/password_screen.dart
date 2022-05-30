import 'package:flutter/material.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/model/user/user_model.dart';
import 'package:pondok207/screen/component/alert_item.dart';
import 'package:pondok207/screen/settings/profile_model_view.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatefulWidget {
  String iduser;
  PasswordScreen({Key? key, required this.iduser}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  var passbaru = TextEditingController();
  var passulangbaru = TextEditingController();

  bool? passwordVisible;
  bool? passwordUlangVisible;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Provider.of<ProfileViewModel>(context, listen: false)
          .getDataUserById(widget.iduser);
    });
    passwordVisible = false;
    passwordUlangVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          margin: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //BAGIAN ATASS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Ubah Password',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ubah password kamu disini,',
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
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('images/logo.png'),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Password baru',
                    style: TextStyle(color: viewModel.primaryColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passbaru,
                    obscureText: !passwordVisible!,
                    validator: (value) => viewModel.isPasswordValid(value!),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      hintText: "Masukkan password baru...",
                      fillColor: Colors.grey[300],
                      filled: true,
                      isDense: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passwordVisible!
                              ? Icons.visibility
                              : Icons.visibility_off,

                          color: viewModel.primaryColor,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            passwordVisible = !passwordVisible!;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ulangi password baru',
                    style: TextStyle(color: viewModel.primaryColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passulangbaru,
                    obscureText: !passwordUlangVisible!,
                    validator: (value) =>
                        viewModel.isPasswordUlangValid(value!),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      hintText: "Ulangi password baru...",
                      fillColor: Colors.grey[300],
                      filled: true,
                      isDense: true,
                      suffixIcon: IconButton(
                        color: viewModel.primaryColor,
                        icon: Icon(
                          // Based on passwordUlangVisible state choose the icon
                          passwordUlangVisible!
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: viewModel.primaryColor,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordUlangVisible variable
                          setState(() {
                            passwordUlangVisible = !passwordUlangVisible!;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Kembali'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              viewModel.changePasswordValid(
                                  context, passbaru.text, passulangbaru.text);
                            }
                          },
                          child: Text("Simpan"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(142, 3, 3, 3)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
