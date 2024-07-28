import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/model/productmodel.dart';
import 'package:flutter_e_commerce/theme/textstyle.dart';
import 'package:flutter_e_commerce/theme/themedata.dart';

// ignore: camel_case_types
class ProductDetails_Screen extends StatefulWidget {
  final Product productdetails;
  final bool showDiscountedPrice;
  final double discountedPrice;
  const ProductDetails_Screen(
      {super.key,
      required this.productdetails,
      required this.showDiscountedPrice,
      required this.discountedPrice});

  @override
  State<ProductDetails_Screen> createState() => _ProductDetails_ScreenState();
}

// ignore: camel_case_types
class _ProductDetails_ScreenState extends State<ProductDetails_Screen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: white,
        centerTitle: false,
        backgroundColor: primarycolor,
        title: Text(
          "e-shop",
          style: text26_700.copyWith(color: white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.productdetails.title,
              style: text18_700.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.productdetails.images.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.productdetails.images[index],
                    width: width - 20,
                    height: 300,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 8),
              child: Text(
                widget.productdetails.description,
                style: text16_500.copyWith(fontSize: 14),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            widget.showDiscountedPrice
                ? Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Text("Price: ",
                          style: text14_400.copyWith(
                            fontSize: 12,
                          )),
                      Text("\$${widget.productdetails.price}",
                          style: text14_400.copyWith(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          "\$${widget.discountedPrice.toStringAsFixed(2)}",
                          style: text14_400.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.productdetails.discountPercentage.toStringAsFixed(2)}% off",
                        overflow: TextOverflow.ellipsis,
                        style: text14_400.copyWith(
                          color: Colors.green,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )
                : Text("Price: \$${widget.productdetails.price}",
                    style: text14_400.copyWith(
                      fontSize: 12,
                    )),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 8),
              child: Text(
                "Brand: ${widget.productdetails.brand}",
                style: text16_500.copyWith(fontSize: 14),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 8),
              child: Text(
                "Minimum Order: ${widget.productdetails.minimumOrderQuantity}",
                style: text16_500.copyWith(fontSize: 14),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 8),
              child: Text(
                "Rating: ${widget.productdetails.rating}/5",
                style: text16_500.copyWith(fontSize: 14),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
