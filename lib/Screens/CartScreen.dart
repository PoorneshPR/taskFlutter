import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flutter/common/fontstyle.dart';
import '../Models/ecommercemodels.dart';
import '../Services/Provider/DbProvider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<DbProvider>().loadProductsFromDb());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(
        builder: (context, value, child) {
          return  Scaffold(
              appBar: AppBar(title: const Text("Cart"), actions: [
                IconButton(
                    onPressed: () {
                      value.deleteAllProductFromDb();
                    },
                    icon: const Icon(Icons.delete))
              ]),
              body: value.productDetails != null
                  ? ListView.separated(
                separatorBuilder: (context, seperateindex) =>
                const SizedBox(height: 10),
                itemCount: value.productDetails!.length,
                itemBuilder: (context, index) {
                  var productPart = value.productDetails?[index];
                  return SizedBox(
                    height: 85,
                    child: ListTile(
                      leading: SizedBox(
                        height: double.infinity,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage:
                          NetworkImage(productPart?.image ?? ""),
                        ),
                      ),
                      title: Text("${productPart?.name}"),
                      tileColor: Colors.grey.shade200,
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${productPart?.actualPrice}",
                              style: FontStyle.greyPriceProduct12Medium),
                          Text(
                            " ${productPart?.offerPrice}",
                            style: FontStyle.blackofferPriceProduct15Medium,
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                          onPressed: () {

                            value.deleteOneProductFromDb(productPart?.id);

                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.blueAccent,
                          )),
                    ),
                  );
                },
              )
                  : value.productDetails == null || value.productDetails!.isEmpty
                  ? const SizedBox(
                  child: Center(child: Text("No Data  to display")))
                  : const CircularProgressIndicator());
        }
           );
  }
}
