import 'package:flutter/material.dart';
import 'package:pondok207/screen/component/bottom_checkout_item.dart';
import 'package:pondok207/screen/component/bottom_keranjang_item.dart';
import 'package:pondok207/screen/home/menu_view_model.dart';
import 'package:pondok207/screen/keranjang/cart_model_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  String id;
  int? index;
  DetailPage({Key? key, required this.id, this.index}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? idUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Provider.of<MenuViewModel>(context, listen: false)
          .getMenuById(widget.id);
    });
    getDataPref();
  }

  void getDataPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    idUser = pref.getString('id');
  }

  @override
  Widget build(BuildContext ctx) {
    final modelView = Provider.of<MenuViewModel>(context);
    final cartmodelView = Provider.of<CartViewModel>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Kembali"),
      ),
      backgroundColor: modelView.primaryColor,
      body: body(modelView, cartmodelView, ctx),
    );
  }
}

Widget body(
    MenuViewModel viewModel, CartViewModel cartmodelView, BuildContext ctx) {
  final isLoading = viewModel.state == MenuViewState.loading;
  final isError = viewModel.state == MenuViewState.error;

  if (isLoading) {
    return const Center(child: CircularProgressIndicator());
  }
  if (isError) {
    return const Center(child: Text('Gagal mengambil data'));
  }
  return detailmenu(viewModel, cartmodelView, ctx);
}

Widget detailmenu(
    MenuViewModel modelView, CartViewModel cartmodelView, BuildContext ctx) {
  return SafeArea(
    child: CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(modelView.datamenu?.gambar ?? ""),
                  radius: 130,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${modelView.datamenu?.createdAt ?? 0}',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${modelView.datamenu?.nama ?? ""}',
                          style: TextStyle(
                              fontSize: 25,
                              color: modelView.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'RP. ${modelView.datamenu?.harga ?? ""}/bungkus',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Apa yang kamu dapat?'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('- Nasi Goreng'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('- 1 ${modelView.datamenu?.nama ?? ""}'),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('- Acar'),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('- Sambal'),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('- Kerupuk'),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 20),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                            context: ctx,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: 270,
                                                child: BuildKeranjangBottom(),
                                              );
                                            },
                                          );
                                        },
                                        child: const Text('Keranjang'),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  modelView.primaryColor),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                            context: ctx,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: 270,
                                                child: BuildCheckoutBottom(),
                                              );
                                            },
                                          );
                                        },
                                        child: const Text('Buat Pesanan'),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  modelView.primaryColor),
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
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
