import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/model/user/user_model.dart';
import 'package:pondok207/screen/component/alert_item.dart';
import 'package:pondok207/screen/component/trasition_item.dart';
import 'package:pondok207/screen/settings/profile_model_view.dart';
import 'package:pondok207/screen/settings/settings_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String id;
  ProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var nama = TextEditingController();
  var email = TextEditingController();
  var nope = TextEditingController();
  var alamat = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileViewModel>(context, listen: false)
          .getDataUserById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final profilemodelView = Provider.of<ProfileViewModel>(context);
    return Scaffold(
      body: body(profilemodelView, context),
    );
  }

  Widget body(ProfileViewModel viewModel, BuildContext ctx) {
    final isLoading = viewModel.state == ProfileViewState.loading;
    final isError = viewModel.state == ProfileViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (isError) {
      return const Center(child: Text('Gagal mengambil data'));
    }
    return detailprofile(viewModel, ctx);
  }

  Widget detailprofile(ProfileViewModel viewModel, BuildContext context) {
    nama = TextEditingController(text: viewModel.datauser?.name ?? '');
    email = TextEditingController(text: viewModel.datauser?.email ?? '');
    nope = TextEditingController(text: viewModel.datauser?.noPhone ?? '');
    alamat = TextEditingController(text: viewModel.datauser?.alamat ?? '');

    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          margin: const EdgeInsets.only(top: 5),
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
                          'Pesananmu',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Hari ini kamu memesan,',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('images/logo.png'),
                  ),
                ),
                Text(
                  'Nama Lengkap',
                  style: TextStyle(color: viewModel.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nama,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: TextDecoration(hint: "Masukkan nama anda.."),
                  validator: (nama) => viewModel.isNameValid(nama!),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Email',
                  style: TextStyle(color: viewModel.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: email,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: TextDecoration(hint: "Masukkan email anda.."),
                  validator: (email) => viewModel.isEmailValid(email!),
                ),

                const SizedBox(
                  height: 10,
                ),
                Text(
                  'No Handphone',
                  style: TextStyle(color: viewModel.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nope,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: TextDecoration(hint: "Masukkan no hp anda.."),
                  validator: (phone) => viewModel.isPhoneValid(phone!),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '   Alamat',
                  style: TextStyle(color: Color.fromRGBO(142, 3, 3, 3)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  controller: alamat,
                  decoration: TextDecoration(hint: "Masukkan alamat anda"),
                  minLines: 6,
                  maxLines: 6,
                  validator: (alamat) => viewModel.isAlamatValid(alamat!),
                ),
                const SizedBox(
                  height: 10,
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
                            viewModel.updateProfile(
                              context,
                              User(
                                createdAt: viewModel.datauser?.createdAt ?? 0,
                                name: nama.text,
                                email: email.text,
                                password: viewModel.datauser?.password ?? '',
                                noPhone: nope.text,
                                alamat: alamat.text,
                                status: '',
                                id: widget.id,
                              ),
                            );
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
    );
  }

  InputDecoration TextDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      fillColor: Colors.grey[300],
      filled: true,
      isDense: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
    );
  }
}
