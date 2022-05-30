import 'package:flutter/material.dart';
import 'package:pondok207/model/menu/menu_model.dart';
import 'package:pondok207/screen/home/menu_view_model.dart';
import 'package:pondok207/screen/component/card_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  void initState() {
    super.initState();

    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Provider.of<MenuViewModel>(context, listen: false).getAllMenu();
      });
    }
    refresh();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final modelView = Provider.of<MenuViewModel>(context);
    return Scaffold(
      body: body(context, modelView),
    );
  }
}

Widget body(BuildContext context, MenuViewModel viewModel) {
  final isLoading = viewModel.state == MenuViewState.loading;
  final isError = viewModel.state == MenuViewState.error;

  if (isLoading) {
    return const Center(child: CircularProgressIndicator());
  }
  if (isError) {
    return const Center(child: Text('Gagal mengambil data'));
  }
  return homemenu(context, viewModel);
}

Widget homemenu(BuildContext context, MenuViewModel modelView) {
  return SafeArea(
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
                    'Selamat Malam',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Mau makan apa hari ini?',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('images/logo.png'),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          //Searching
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  onChanged: (String? value) {
                    if (value != null && value.isNotEmpty) {
                      Provider.of<MenuViewModel>(context, listen: false)
                          .searching(context, value);
                    }
                  },
                  controller: modelView.firstTextController,
                  decoration: InputDecoration(
                    hintText: "Nasi goreng...",
                    fillColor: Colors.grey[300],
                    filled: true,
                    isDense: true,
                    suffixIcon: Icon(
                      Icons.search,
                      color: modelView.primaryColor,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Semua Menu',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: modelView.searchMenus.isEmpty
                      ? GridView.builder(
                          itemCount: modelView.menus.length,
                          itemBuilder: (context, index) {
                            final menu = modelView.menus[index];
                            return ItemCard(menu: menu, index: index);
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisExtent: 235,
                          ),
                        )
                      : GridView.builder(
                          itemCount: modelView.searchMenus.length,
                          itemBuilder: (context, index) {
                            final menu = modelView.searchMenus[index];
                            return ItemCard(menu: menu, index: index);
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisExtent: 235,
                          ),
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
