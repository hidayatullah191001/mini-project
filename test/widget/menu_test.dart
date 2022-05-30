import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pondok207/screen/home/home_screen.dart';
import 'package:pondok207/screen/home/menu_view_model.dart';
import 'package:provider/provider.dart';

Widget _createMenuScreen() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => MenuViewModel(),
      ),
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}

void main() {
  group('MenuViewModel', () {
    MenuViewModel menuViewModel = MenuViewModel();
    test('Change State', () async {
      expect(menuViewModel.state, MenuViewState.none);
      menuViewModel.changeState(MenuViewState.loading);
      expect(menuViewModel.state, MenuViewState.loading);
    });

    test('GetAllMenu', () async {
      menuViewModel.changeState(MenuViewState.loading);
      try {
        await menuViewModel.getAllMenu();
        expect(menuViewModel.menus.isNotEmpty, true);
        menuViewModel.changeState(MenuViewState.none);
      } catch (e) {
        menuViewModel.changeState(MenuViewState.error);
      }
    });

    test('GetById', () async {
      await menuViewModel.getMenuById('1');
      expect(menuViewModel.datamenu?.nama, 'Nasi Goreng Telur Dadar');
    });
  });

  group('Test Widget', () {
    MenuViewModel menuViewModel = MenuViewModel();

    testWidgets('Testing Text', (WidgetTester tester) async {
      await tester.pumpWidget(_createMenuScreen());
      menuViewModel.changeState(MenuViewState.loading);
      try {
        await tester.pumpAndSettle(const Duration(seconds: 5));
        expect(find.text('Selamat Malam'), findsOneWidget);
        menuViewModel.changeState(MenuViewState.none);
      } catch (e) {
        menuViewModel.changeState(MenuViewState.error);
      }
    });

    testWidgets('Testing GridView', (WidgetTester tester) async {
      await tester.pumpWidget(_createMenuScreen());
      menuViewModel.changeState(MenuViewState.loading);
      try {
        await tester.pumpAndSettle(const Duration(seconds: 5));
        expect(find.byType(GridView), findsOneWidget);
        menuViewModel.changeState(MenuViewState.none);
      } catch (e) {
        menuViewModel.changeState(MenuViewState.error);
      }
    });

    testWidgets('Testing GestureDetector', (WidgetTester tester) async {
      await tester.pumpWidget(_createMenuScreen());
      menuViewModel.changeState(MenuViewState.loading);
      try {
        await tester.pumpAndSettle(const Duration(seconds: 5));
        expect(find.byType(GestureDetector), findsOneWidget);
        menuViewModel.changeState(MenuViewState.none);
      } catch (e) {
        menuViewModel.changeState(MenuViewState.error);
      }
    });
  });
}
