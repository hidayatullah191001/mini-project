import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pondok207/screen/component/alert_item.dart';
import 'package:pondok207/screen/component/item_keranjang.dart';
import 'package:pondok207/screen/component/trasition_item.dart';
import 'package:pondok207/screen/keranjang/cart_model_view.dart';
import 'package:pondok207/screen/keranjang/checkout_keranjang_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? idUser;

  @override
  void initState() {
    super.initState();
    getDataPref();
    refresh();
  }

  void getDataPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idUser = pref.getString('id');
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cartmodelView = Provider.of<CartViewModel>(context);
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
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 465,
                            child: ListView.builder(
                              itemCount: cartmodelView.carts.length,
                              itemBuilder: (context, index) {
                                final keranjang = cartmodelView.carts[index];
                                return ItemKeranjang(
                                  keranjang: keranjang,
                                  index: index,
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 10.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 75,
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Total Harga Pesanan",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              "Rp. " +
                                                  cartmodelView
                                                      .totalharga()
                                                      .toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Color.fromRGBO(
                                                    142, 3, 3, 3),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (cartmodelView.carts.length <
                                                1) {
                                              AlertInfo(context,
                                                  "Keranjang kamu kosong!");
                                            } else {
                                              Navigator.push(
                                                context,
                                                TransisiHalaman(
                                                  tipe: PageTransitionType
                                                      .leftToRight,
                                                  page: CheckoutKeranjangScreen(
                                                      iduser: idUser ?? ''),
                                                ),
                                              ).then((value) => refresh());
                                            }
                                          },
                                          child: const Text("Bayar"),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              cartmodelView.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
