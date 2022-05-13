import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flutter/DbHelper/DbConnection.dart';
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
    return Consumer<DbProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(title: const Text("Cart"), actions: [
            IconButton(
                onPressed: () {
                  value.deleteAllProductFromDb();
                },
                icon: const Icon(Icons.delete))
          ]),
          body: value.productDetails != null && value.productDetails!.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, seperateindex) =>
                      const SizedBox(height: 10),
                  itemCount: value.productDetails!.length,
                  itemBuilder: (context, index) {
                    var productPart = value.productDetails?[index].product;
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
                        title: SizedBox(
                            height: 30,
                            child: Text(
                              "${productPart?.name}",
                              style: FontStyle.black15Bold,
                              maxLines: 2,
                            )),
                        tileColor: Colors.grey.shade200,
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("${productPart?.actualPrice}",
                                    style: FontStyle.greyPriceProduct12Medium),
                                Text(
                                  " ${productPart?.offerPrice}",
                                  style:
                                      FontStyle.blackofferPriceProduct15Medium,
                                ),
                              ],
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 25,
                                width: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    FloatingActionButton(
                                      backgroundColor: Colors.white,
                                      onPressed: () {},
                                      child: const Icon(Icons.remove,
                                          color: Colors.black87, size: 26),
                                    ),
                                    Container(
                                      width: 30,
                                      padding: const EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(77),
                                        color: Colors.blue,
                                      ),
                                      child: Text(
                                        "${value.productDetails?[index].quantityCount}",
                                        style: FontStyle
                                            .whiteSingleCartAdd15medium,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    FloatingActionButton(
                                      backgroundColor: Colors.white,
                                      onPressed: () {},
                                      child: const Icon(Icons.add,
                                          color: Colors.black87, size: 26),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                            onPressed: () {
                              value.deleteOneProductFromDb(value
                                  .productDetails![index].productTableId!
                                  .toInt());
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.blueAccent,
                            )),
                      ),
                    );
                  },
                )
              : const SizedBox(
                  child: Center(child: Text("No items  to display"))));
    });
  }
}
