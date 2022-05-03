import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flutter/Screens/HomeScreen.dart';
import 'package:task_flutter/common/fontstyle.dart';
import '../Models/ecommercemodels.dart';
import '../Services/Provider/HomeProvider.dart';
import '../Services/service_config.dart';
import '../common/constants.dart';
import '../utils/hexcolors.dart';

import 'newscreen.dart';
class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  TextEditingController searchController = TextEditingController();
  String textController="";

  @override
  void initState() {
    Future.microtask(() => context.read<HomeProvider>()
      ..homeInit()
      ..gethomeData());

    // TODO: implement initState
    super.initState();
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
                return CircularProgressIndicator();
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

                  //
                  // buildBottomBar()
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return CircularProgressIndicator();
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
          const SizedBox(),
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
                        onTap: () {
                          print(searchController.text);
                        },
                        // onChanged: ,
                        textAlign: TextAlign.left,
                        // textInputAction: textInputAction,
                        style: FontStyle.grey14Medium,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 10, right: 10),
                          hintText: "Search",
                          hintStyle: FontStyle.grey14Medium,
                          isDense: true,
                          border: InputBorder.none,
                        )),
                  ),
//scan icon implemented
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
      margin: EdgeInsets.fromLTRB(0.0, 12, 0.0, 0.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, _index) => GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(
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
    return CarouselSlider.builder(
      itemCount: banners.length,
      itemBuilder: (context, index, realIndex) => Stack(
        children: [
          InkWell(
            child: Container(
              color: Colors.grey[50],
              child: FadeInImage(
                image: NetworkImage(banners[index].bannerUrl.toString()),
                placeholder: const AssetImage(
                    "assets/Pink-Rose-HD-Wallpaper-1920x1080.jpg"),
                height: double.maxFinite,
                width: double.maxFinite,
                fit: BoxFit.contain,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
      options: CarouselOptions(
          aspectRatio: 1.80,
          viewportFraction: 0.85,
          enlargeCenterPage: false,
          enableInfiniteScroll: true,
          initialPage: 1,
          autoPlay: true,
          height: 166),
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
        padding: EdgeInsets.only(right: 8, left: 8),
        itemCount: products.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            right: 8,
          ),
          child: Container(
            width: 158,
            decoration: BoxDecoration(
              border: Border.all(
                color: HexColors("#EDEDED"),
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(
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
                      padding: EdgeInsets.only(top: 13),
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
                          const SizedBox(
                            child: Text(""),
                            height: 15,
                            width: 22,
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
                      products[index].isExpress == null
                          ? SizedBox(
                              height: 15,
                              width: 22,
                              child: Image.asset("assets/express.png"),
                            )
                          : const SizedBox(
                              child: Text(""),
                              height: 15,
                              width: 22,
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
                      onPressed: () {},
                      child: const Text("ADD"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColors("#199B3B")),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
