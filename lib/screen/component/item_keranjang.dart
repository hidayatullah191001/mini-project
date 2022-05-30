import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:pondok207/model/keranjang/cart_model.dart';
import 'package:pondok207/screen/component/alert_item.dart';
import 'package:pondok207/screen/keranjang/cart_model_view.dart';
import 'package:provider/provider.dart';

class ItemKeranjang extends StatelessWidget {
  int? index;
  Keranjang keranjang;

  ItemKeranjang({Key? key, required this.keranjang, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartmodelView = Provider.of<CartViewModel>(context);

    Color primaryColor = Color.fromRGBO(142, 3, 3, 3);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Container(
                child: Image.network(
                  keranjang.image!, // set your height
                  width: 115, // and width here
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    keranjang.nama!,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Rp. ${keranjang.harga}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Jumlah pesan : ${keranjang.banyak.toString()}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: primaryColor,
              child: IconButton(
                onPressed: () {
                  if (index! == 0) {
                  } else {
                    cartmodelView.deleteItem(index!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Berhasil dihapus dari keranjang!')),
                    );
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                iconSize: 14,
              ),
              radius: 15,
            ),
          ],
        ),
      ),
    );
  }
}
