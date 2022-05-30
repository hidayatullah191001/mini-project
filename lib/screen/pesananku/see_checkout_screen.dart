import 'package:flutter/material.dart';
import 'package:pondok207/screen/component/item_checkout.dart';
import 'package:pondok207/screen/pesananku/pesanan_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeeCheckoutScreen extends StatefulWidget {
  String? email;
  SeeCheckoutScreen({Key? key, this.email}) : super(key: key);

  @override
  State<SeeCheckoutScreen> createState() => _SeeCheckoutScreenState();
}

class _SeeCheckoutScreenState extends State<SeeCheckoutScreen> {
  @override
  void initState() {
    super.initState();
    getDataPref();
    fetchData();
  }

  Future<void> fetchData() async {
    print('PULL TO REFRESH CALLBACK');
    setState(() {});
    getDataPref();
  }

  getDataPref() async {
    String email = '';
    SharedPreferences pref = await SharedPreferences.getInstance();
    email = pref.getString('email')!;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<PesananViewModel>(context, listen: false)
          .getAllPembayaran(email);
    });
  }

  Widget build(BuildContext context) {
    final PesananmodelView = Provider.of<PesananViewModel>(context);
    return Scaffold(
      body: body(PesananmodelView, context),
    );
  }

  Widget body(PesananViewModel viewModel, BuildContext ctx) {
    final isLoading = viewModel.state == PesananViewState.loading;
    final isError = viewModel.state == PesananViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (isError) {
      return const Center(child: Text('Gagal mengambil data'));
    }
    return SeeCheckout(viewModel, ctx);
  }

  Widget SeeCheckout(PesananViewModel viewModel, BuildContext context) {
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
                  children: [
                    Text(
                      'Pesananmu',
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
            Flexible(
              child: viewModel.CheckoutList.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Belum ada pesananan nih!'),
                          SizedBox(
                            height: 6,
                          ),
                          IconButton(
                              onPressed: () {
                                fetchData();
                              },
                              icon: Icon(Icons.refresh)),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: fetchData,
                      child: ListView.builder(
                        itemCount: viewModel.CheckoutList.length,
                        itemBuilder: (context, index) {
                          final pembayaran = viewModel.CheckoutList[index];
                          return ItemCheckout(
                            pembayaranChek: pembayaran,
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
