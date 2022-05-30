import 'package:flutter/material.dart';
import 'package:pondok207/model/api/api_service.dart';
import 'package:pondok207/model/keranjang/pembayaranchek_model.dart';
import 'package:pondok207/model/keranjang/pembayaranker_model.dart';
import 'package:pondok207/screen/component/alert_item.dart';
import 'package:pondok207/screen/component/item_keranjang.dart';
import 'package:pondok207/screen/keranjang/cart_model_view.dart';
import 'package:provider/provider.dart';

class CheckoutKeranjangScreen extends StatefulWidget {
  String iduser;
  CheckoutKeranjangScreen({Key? key, required this.iduser}) : super(key: key);

  @override
  _CheckoutKeranjangScreenState createState() =>
      _CheckoutKeranjangScreenState();
}

class _CheckoutKeranjangScreenState extends State<CheckoutKeranjangScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Provider.of<CartViewModel>(context, listen: false)
          .getUserById(widget.iduser);
    });
  }

  List<PembayaranChek> listitemPembayaranKer = [];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CartViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          margin: EdgeInsets.only(top: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //BAGIAN ATASS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Bayaranmu',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rincian Pesananmu,',
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      child: ListView.builder(
                        itemCount: viewModel.carts.length,
                        itemBuilder: (context, index) {
                          return ItemKeranjang(
                            keranjang: viewModel.carts[index],
                          );
                        },
                      ),
                    ),
                    const CardAlamat(),
                    CardMetodeBayar(),
                    CardRincianBayar(cartmodelView: viewModel),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (viewModel.datauser?.alamat != '') {
                              if (viewModel.getMethod().toString() != '') {
                                DateTime dateToday = new DateTime.now();
                                String date =
                                    dateToday.toString().substring(0, 10);
                                for (var i = 0;
                                    i < viewModel.carts.length;
                                    i++) {
                                  listitemPembayaranKer.add(
                                    PembayaranChek(
                                      nama: viewModel.carts[i].nama ?? '',
                                      gambar: viewModel.carts[i].image ?? '',
                                      totalbayar: viewModel
                                          .totalBayar(viewModel.carts[i].harga!)
                                          .toString(),
                                      banyak:
                                          viewModel.carts[i].banyak.toString(),
                                      namauser: viewModel.datauser?.name ?? '',
                                      alamat: viewModel.datauser?.alamat ?? '',
                                      email: viewModel.datauser?.email ?? '',
                                      status: 'Dalam antrian',
                                      id: viewModel.carts[i].id.toString(),
                                      metode: viewModel.getMethod().toString(),
                                      datetime: date,
                                    ),
                                  );
                                }
                                ApiService()
                                    .bayarker(PembayaranKer(
                                        data: listitemPembayaranKer))
                                    .then((value) => viewModel.carts
                                        .removeRange(
                                            0, viewModel.carts.length));
                                AlertSucces(context, "Pesanan berhasil dibuat!")
                                    .then((value) => Navigator.pop(context));
                              } else {
                                AlertError(context,
                                    "Kamu belum pilih metode pembayaran!");
                              }
                            } else {
                              AlertError(context, "Alamat kamu masih kosong!");
                            }
                          },
                          child: const Text('Bayar Sekarang'),
                          style: ElevatedButton.styleFrom(
                            primary: viewModel.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CardMetodeBayar extends StatefulWidget {
  CardMetodeBayar({Key? key}) : super(key: key);

  @override
  State<CardMetodeBayar> createState() => _CardMetodeBayarState();
}

class _CardMetodeBayarState extends State<CardMetodeBayar> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CartViewModel>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bayar dengan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Transform.scale(
              alignment: Alignment.topLeft,
              scale: 0.9,
              child: Row(
                children: [
                  Radio(
                    value: 'Cashless / bayar dirumah',
                    groupValue: viewModel.getMethod().toString(),
                    onChanged: (String? value) {
                      setState(() {
                        viewModel.setMethod(value!) ?? '';
                      });
                    },
                  ),
                  Text('Cashless / bayar dirumah'),
                ],
              ),
            ),
            Transform.scale(
              alignment: Alignment.topLeft,
              scale: 0.9,
              child: Row(
                children: [
                  Radio(
                    value: 'emoney',
                    groupValue: viewModel.getMethod().toString(),
                    onChanged: (String? value) {
                      setState(() {
                        viewModel.setMethod(value!) ?? '';
                      });
                    },
                  ),
                  Text('E-Money'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardAlamat extends StatelessWidget {
  const CardAlamat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartmodelView = Provider.of<CartViewModel>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5.0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Antar Ke',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            if (cartmodelView.datauser?.alamat == '') ...[
              Center(
                child: Text(
                  '"Alamat anda belum diisi, isi terlebih dahulu!"',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cartmodelView.primaryColor),
                ),
              ),
            ] else ...[
              Text(
                '${cartmodelView.datauser?.alamat}',
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class CardRincianBayar extends StatelessWidget {
  const CardRincianBayar({
    Key? key,
    required this.cartmodelView,
  }) : super(key: key);

  final CartViewModel cartmodelView;

  @override
  Widget build(BuildContext context) {
    final cartmodelView = Provider.of<CartViewModel>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5.0,
      child: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        margin: EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rincian Bayar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              child: ListView.builder(
                itemCount: cartmodelView.carts.length,
                itemBuilder: (context, i) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${cartmodelView.carts[i].banyak} ${cartmodelView.carts[i].nama}',
                      ),
                      Text(
                        'Rp. ${cartmodelView.carts[i].harga}',
                        style: TextStyle(
                          color: cartmodelView.primaryColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ongkos Kirim',
                ),
                Text(
                  'Rp. ${cartmodelView.getOngkir()}',
                  style: TextStyle(
                    color: cartmodelView.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Bayar',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: cartmodelView.primaryColor),
                ),
                Text(
                  'Rp. ${cartmodelView.totalBayar(cartmodelView.totalharga()).toString()}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: cartmodelView.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
