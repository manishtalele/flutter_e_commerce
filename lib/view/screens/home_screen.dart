import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/constant/variable.dart';
import 'package:flutter_e_commerce/controller/getproductdata.dart';
import 'package:flutter_e_commerce/controller/remoteconfig.dart';
import 'package:flutter_e_commerce/model/productmodel.dart';
import 'package:flutter_e_commerce/theme/textstyle.dart';
import 'package:flutter_e_commerce/theme/themedata.dart';
import 'package:flutter_e_commerce/view/screens/profile_screen.dart';
import 'package:flutter_e_commerce/view/widgets/productcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product>? product;
  var isLoaded = false;
  ProductCard? productcard;

  // ignore: non_constant_identifier_names
  Refresh() async {
    await fetchAndActivateRemoteConfig();
    setState(() {
      showPrice = showPrice;
    });
  }

  @override
  void initState() {
    getproData();
    super.initState();
  }

  getproData() async {
    productcard = await GetProductData().getData();
    product = productcard!.products;
    if (product != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Refresh(),
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: primarycolor,
            title: Text(
              "e-shop",
              style: text26_700.copyWith(color: white, fontSize: 20),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
                  },
                  icon: Icon(
                    Icons.person,
                    color: white,
                  ))
            ],
          ),
          body: isLoaded
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.54,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 16.0,
                          ),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: product!.length,
                          itemBuilder: (context, index) {
                            return ProductCards(
                              productdetails: product![index],
                              showDiscountedPrice: showPrice,
                            );
                          }),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator())),
    );
  }
}
