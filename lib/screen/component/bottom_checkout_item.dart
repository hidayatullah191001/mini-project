import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pondok207/model/keranjang/cart_model.dart';
import 'package:pondok207/screen/component/alert_item.dart';
import 'package:pondok207/screen/component/trasition_item.dart';
import 'package:pondok207/screen/home/menu_view_model.dart';
import 'package:pondok207/screen/keranjang/cart_model_view.dart';
import 'package:pondok207/screen/keranjang/checkout_pesanan_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildCheckoutBottom extends StatefulWidget {
  BuildCheckoutBottom({Key? key}) : super(key: key);

  @override
  State<BuildCheckoutBottom> createState() => _BuildCheckoutBottomState();
}

class _BuildCheckoutBottomState extends State<BuildCheckoutBottom> {
  String? idUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPref();
  }

  void getDataPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idUser = pref.getString('id');
  }

  @override
  Widget build(BuildContext context) {
    final modelView = Provider.of<MenuViewModel>(context);
    final cartmodelView = Provider.of<CartViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            "Nasi Goreng ${modelView.datamenu?.nama ?? ""}",
            style: TextStyle(
              color: modelView.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(modelView.datamenu?.gambar ?? ""),
                    radius: 50,
                  ),
                ],
              ),
              const Text("Banyak Pesan : "),
              CircleAvatar(
                backgroundColor: modelView.primaryColor,
                radius: 15,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      modelView.kurangpesan();
                    });
                  },
                  icon: Icon(
                    Icons.do_not_disturb_on_outlined,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                '${modelView.getBanyak()}',
                style: TextStyle(
                    color: modelView.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                backgroundColor: modelView.primaryColor,
                radius: 15,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      modelView.tambahpesan();
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              _checkout(modelView, cartmodelView, idUser ?? '');
            },
            child: const Text('Buat Pesanan'),
            style: ElevatedButton.styleFrom(
              primary: modelView.primaryColor,
              minimumSize: const Size.fromHeight(45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkout(
      MenuViewModel menuViewModel, CartViewModel cartmodelView, String idUser) {
    var totalbelanja;
    int id = 1;
    int harga = menuViewModel.datamenu?.harga ?? 0;
    int banyak = menuViewModel.getBanyak();
    setState(() {
      totalbelanja = banyak * harga;
      if (totalbelanja != null && banyak >= 1) {
        id++;
        Navigator.push(
          context,
          TransisiHalaman(
            tipe: PageTransitionType.rightToLeftWithFade,
            page: CheckoutPesananScreen(
              iduser: idUser,
              keranjang: Keranjang(
                  emailuser: menuViewModel.emailuser,
                  nama: menuViewModel.datamenu?.nama,
                  harga: totalbelanja,
                  banyak: banyak,
                  image: menuViewModel.datamenu?.gambar,
                  id: id),
            ),
          ),
        );
      } else if (banyak < 1) {
        AlertInfo(context, 'Minimal 1 bungkus!');
      }
    });
  }
}
