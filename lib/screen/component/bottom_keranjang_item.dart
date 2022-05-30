import 'package:flutter/material.dart';
import 'package:pondok207/model/keranjang/cart_model.dart';
import 'package:pondok207/screen/component/alert_item.dart';
import 'package:pondok207/screen/home/menu_view_model.dart';
import 'package:pondok207/screen/keranjang/cart_model_view.dart';
import 'package:provider/provider.dart';

class BuildKeranjangBottom extends StatefulWidget {
  const BuildKeranjangBottom({Key? key}) : super(key: key);

  @override
  State<BuildKeranjangBottom> createState() => _BuildKeranjangBottomState();
}

class _BuildKeranjangBottomState extends State<BuildKeranjangBottom> {
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
              _tambahKeranjang(modelView, cartmodelView);
            },
            child: const Text('Masukkan Keranjang'),
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

  void _tambahKeranjang(
      MenuViewModel menuViewModel, CartViewModel cartmodelView) {
    var totalbelanja;
    int id = 1;
    int harga = menuViewModel.datamenu?.harga ?? 0;
    int banyak = menuViewModel.getBanyak();
    setState(() {
      totalbelanja = banyak * harga;
      if (totalbelanja != null && banyak >= 1) {
        AlertSucces(context, 'Berhasil ditambahkan ke Keranjang');
        id++;
        cartmodelView.addKeranjang(
          data: Keranjang(
              emailuser: menuViewModel.emailuser,
              nama: menuViewModel.datamenu?.nama,
              harga: totalbelanja,
              banyak: banyak,
              image: menuViewModel.datamenu?.gambar,
              id: id),
        );
      } else if (banyak < 1) {
        AlertInfo(context, 'Minimal 1 bungkus!');
      }
    });
  }
}
