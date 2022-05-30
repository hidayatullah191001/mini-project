import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pondok207/screen/component/trasition_item.dart';
import 'package:pondok207/screen/home/detail_screen.dart';

import '../../model/menu/menu_model.dart';

class ItemCard extends StatelessWidget {
  final Menu menu;
  final int index;

  const ItemCard({Key? key, required this.menu, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color.fromRGBO(142, 3, 3, 3);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          TransisiHalaman(
            tipe: PageTransitionType.scale,
            align: Alignment.center,
            page: DetailPage(
              id: menu.id!,
              index: index,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Container(
                  child: Image.network(
                    menu.gambar!,
                    height: 110, // set your height
                    width: 115, // and width here
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp.${menu.harga}',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6),
                      CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 15,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              TransisiHalaman(
                                tipe: PageTransitionType.size,
                                align: Alignment.center,
                                page: DetailPage(
                                  id: menu.id!,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
