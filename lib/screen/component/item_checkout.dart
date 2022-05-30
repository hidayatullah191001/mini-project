import 'package:flutter/material.dart';
import 'package:pondok207/model/keranjang/cart_model.dart';
import 'package:pondok207/model/keranjang/pembayaranchek_model.dart';

class ItemCheckout extends StatelessWidget {
  PembayaranChek pembayaranChek;

  ItemCheckout({Key? key, required this.pembayaranChek}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color.fromRGBO(142, 3, 3, 3);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Center(
              child: Container(
                child: Image.network(
                  pembayaranChek.gambar!, // set your height
                  width: 100, // and width here
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
                    pembayaranChek.nama!,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Total Bayar : Rp. ${pembayaranChek.totalbayar}',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Status : ${pembayaranChek.status}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
