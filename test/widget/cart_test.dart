import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pondok207/model/keranjang/cart_model.dart';
import 'package:pondok207/screen/component/item_keranjang.dart';
import 'package:pondok207/screen/home/home_screen.dart';
import 'package:pondok207/screen/keranjang/cart_model_view.dart';
import 'package:pondok207/screen/keranjang/cart_screen.dart';
import 'package:provider/provider.dart';

Widget _createCartScreen() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => CartViewModel(),
      ),
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartScreen(),
    ),
  );
}

void main() {
  group('CartViewModel', () {
    CartViewModel cartViewModel = CartViewModel();
    test('AddKeranjang', () async {
      await cartViewModel.addKeranjang(
          data: Keranjang(
              emailuser: 'hidayatullahbp@gmail.com',
              nama: 'Nasi Goreng Telur Dadar',
              harga: 11000,
              banyak: 1,
              image: 'telurdadar.png',
              id: 3));
      expect(cartViewModel.carts.isNotEmpty, true);
    });
  });

  group('Test Widget', () {
    CartViewModel cartViewModel = CartViewModel();

    testWidgets('Testing Text', (WidgetTester tester) async {
      await tester.pumpWidget(_createCartScreen());
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text('Pesananmu'), findsOneWidget);
    });

    testWidgets('Testing ListView', (WidgetTester tester) async {
      await tester.pumpWidget(_createCartScreen());
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing ElavatedButton', (WidgetTester tester) async {
      await tester.pumpWidget(_createCartScreen());
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
