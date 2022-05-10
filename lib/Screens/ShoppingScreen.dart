import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flutter/common/fontstyle.dart';

import '../Models/ecommercemodels.dart';
import '../Services/Provider/DbProvider.dart';
import '../Services/Provider/HomeProvider.dart';
import '../Services/service_config.dart';
import '../common/constants.dart';
import '../utils/hexcolors.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  TextEditingController searchController = TextEditingController();
  String textController = "";
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    Future.microtask(() => context.read<HomeProvider>()
      ..homeInit()
      ..gethomeData());
    _pageController = PageController(
      initialPage: 0,
    );
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      return setState(() {
        if (_currentPage < 2) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildAllItems();
  }

  Widget buildAllItems() {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Consumer<HomeProvider>(builder: (context, value, child) {
            if (value.ecommerceModel == null) {
              return Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
                height: MediaQuery.of(context).size.height,
              );
            } else if (value.pageLoadState == LoadState.loaded &&
                value.ecommerceModel?.homeData != null) {
              List<Value>? category;
              List<Value>? banners;
              List<Value>? products;

              List<HomeData>? homeData = value.ecommerceModel?.homeData;
              if (homeData != null) {
                for (int i = 0; i < homeData.length; i++) {
                  if (homeData[i].type == 'category') {
                    category = homeData[i].values;
                  } else if (homeData[i].type == 'banners') {
                    banners = homeData[i].values;
                  } else if (homeData[i].type == 'products') {
                    products = homeData[i].values;
                  }
                }
              } else {
                return const CircularProgressIndicator();
              }
              return Column(
                children: [
                  buildSearchField(textController),
                  circularTileCategory(category!),
                  bannerBuildShoppingScreen(banners!),
                  const SizedBox(
                    height: 12,
                  ),
                  buildProductTile(
                    products!,
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }

  Widget buildSearchField(
    String textController,
  ) {
    return Container(
        margin: const EdgeInsets.fromLTRB(12, 40, 12, 0),
        alignment: Alignment.centerLeft,
        child: Row(children: [
          Expanded(
              child: Container(
            width: double.maxFinite,
            height: 45,
            decoration: BoxDecoration(
                color: HexColors("#FAFAFA"),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: HexColors("#C5C5C5"))),
            alignment: Alignment.center,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      "assets/searchsmall.png",
                      height: 17,
                      width: 17,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                        controller: searchController,
                        cursorColor: HexColors('#868788'),
                        onTap: () {},
                        // onChanged: ,
                        textAlign: TextAlign.left,
                        // textInputAction: textInputAction,
                        style: FontStyle.grey14Medium,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 10),
                          hintText: "Search",
                          hintStyle: FontStyle.grey14Medium,
                          isDense: true,
                          border: InputBorder.none,
                        )),
                  ),
//scan icon implemented
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      "assets/searchscan.png",
                      height: 17,
                      width: 17,
                    ),
                  ),
                ]),
          )),
        ]));
  }

  Widget circularTileCategory(
    List<Value> value,
  ) {
    return Container(
      width: double.maxFinite,
      height: 104,
      margin: const EdgeInsets.fromLTRB(0.0, 12, 0.0, 0.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, _index) => GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 0.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: HexColors(Constants.categoryColorCode[0]),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                            ),
                            width: 60,
                            height: 60,
                          ),
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                  value[_index].imageUrl.toString()))
                        ],
                      ),
                      Expanded(
                        child: Container(
                          width: 80,
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(
                            top: 4.0,
                          ),
                          child: Text(
                            "${value[_index].name}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: FontStyle.black14Medium,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          itemCount: value.length),
    );
  }

  Widget bannerBuildShoppingScreen(List<Value> banners) {
    return Container(margin: EdgeInsets.symmetric(horizontal: 4),
      height: 181,
      child: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          return Transform.scale(
              scale: 1,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                    imageUrl: banners[index].bannerUrl.toString(),
                    height: double.maxFinite,
                    width: double.maxFinite,
                    fit: BoxFit.fill,
                  );
                },
                itemCount: banners.length, // Can be null
              ));
        },
        //
      ),
    );
  }
  Widget buildProductTile(
    List<Value> products,
  ) {
    Widget _buildTitleWidget(String s) {
      return Text(s,
          maxLines: 2,
          strutStyle: const StrutStyle(height: 1.5),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: FontStyle.black13medium);
    }

    return SizedBox(
      width: double.maxFinite,
      height: 284,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 8, left: 8),
        itemCount: products.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            right: 8,
          ),
          child: Container(
            width: 158,
            decoration: BoxDecoration(
              border: Border.all(
                color: HexColors("#EDEDED"),
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: <Widget>[
                          Stack(
                            children: [
                              Image.asset(
                                "assets/Path 30035@3x.png",
                                height: 12,
                                width: 42,
                                alignment: Alignment.topCenter,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                products[index].offer.toString() + "%OFF",
                                style: FontStyle.white10medium,
                                overflow: TextOverflow.visible,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10, top: 13),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Image.asset(
                            Constants.favicon,
                            height: 18,
                            width: 16,
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: 102,
                    width: 102,
                    child: Image.network(
                        products.elementAt(index).image.toString())),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      products[index].isExpress == false
                          ? const SizedBox(
                              child: Text(""),
                              height: 15,
                              width: 22,
                            )
                          : SizedBox(
                              height: 15,
                              width: 22,
                              child: Image.asset("assets/express.png"),
                            ),
                      Text("${products[index].actualPrice}",
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: FontStyle.greyPriceProduct12Medium,
                          textDirection: TextDirection.ltr),
                      Text(
                        "${products[index].offerPrice}",
                        style: FontStyle.blackofferPriceProduct15Medium,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                          height: 50,
                          child: _buildTitleWidget('${products[index].name} ')),
                      // _buildSubTitleWidget("${products[index].id.toString()}"),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {

                        Future.microtask(() => context.read<DbProvider>().insertProductToDb(products[index]));



                      },
                      child: const Text("ADD"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColors("#199B3B")),
                      ),
                    )),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
