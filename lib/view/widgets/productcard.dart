import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/model/productmodel.dart';
import 'package:flutter_e_commerce/theme/textstyle.dart';
import 'package:flutter_e_commerce/theme/themedata.dart';
import 'package:flutter_e_commerce/view/screens/productdetails.dart';

class ProductCards extends StatefulWidget {
  final Product productdetails;
  final bool showDiscountedPrice;

  const ProductCards(
      {super.key,
      required this.productdetails,
      this.showDiscountedPrice = false});

  @override
  State<ProductCards> createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {
  double? discountedPrice;
  calculatediscountprice() {
    discountedPrice = widget.productdetails.price *
        (1 - widget.productdetails.discountPercentage / 100);
  }

  @override
  void initState() {
    super.initState();
    calculatediscountprice();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetails_Screen(
                productdetails: widget.productdetails,
                showDiscountedPrice: widget.showDiscountedPrice,
                discountedPrice: discountedPrice!,
              ))),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: white),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  widget.productdetails.thumbnail,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            Text(
              widget.productdetails.title,
              style: text18_700.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 8),
              child: Text(
                widget.productdetails.description,
                style: text16_500.copyWith(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            widget.showDiscountedPrice
                ? Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Text("\$${widget.productdetails.price}",
                          style: text14_400.copyWith(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          "\$${discountedPrice!.toStringAsFixed(2)}",
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
                : Text("\$${widget.productdetails.price}",
                    style: text14_400.copyWith(
                      fontSize: 12,
                    )),
          ],
        ),
      ),
    );
  }
}
